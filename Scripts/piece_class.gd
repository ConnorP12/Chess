extends Node2D
class_name Piece

var moves: Array
var boardPosition: Vector2i
var selected: bool
var colour: String
var board
var held: bool
signal piece_moved

func possible_moves(_enemyPieces: Array[Piece], _teamPieces: Array[Piece]) -> Array:
	moves = [Vector2i(3, 2)]
	return moves #make the moves



func _process(_delta: float) -> void:
	#if held == true and Input.is_action_pressed("click"):
		#global_position = get_global_mouse_position()
	#else:
	global_position = board.get_tile_position(boardPosition)
	if selected == true:
		#make move and stuff
		pass


func _on_board_square_clicked(square: Vector2i) -> void:
	if selected == false:
		if square == boardPosition:
			selected = true
			held = true
		else:
			selected = false
			held = false
	else:
		for i in moves:
			if i.x == square.x and i.y == square.y:
				boardPosition = square
				selected = false
				held = false
				piece_moved.emit()
		
func slide( p: Vector2i, x: int, y: int, enemyPieces: Array[Piece], teamPieces: Array[Piece]) -> Array:
	var newMoves: Array
	var teamOnSquare: bool = false
	var enemyOnSquare: bool = false
	
	if p.x + x <= 7 and p.x + x >= 0 and p.y <= 7 and p.y >= 0:
		for piece in enemyPieces:
			if piece.boardPosition.x == p.x + x and piece.boardPosition.y == p.y + y:
				newMoves.append(Vector2i(p.x + x, p.y + y))
				enemyOnSquare = true
		for piece in teamPieces:
			if piece.boardPosition.x == p.x + x and piece.boardPosition.y == p.y + y:
				teamOnSquare = true
		if enemyOnSquare == false and teamOnSquare == false:
			newMoves.append(Vector2i(p.x + x, p.y + y))
			newMoves.append_array(slide(Vector2i(p.x + x, p.y + y), x, y, enemyPieces, teamPieces))
	return newMoves