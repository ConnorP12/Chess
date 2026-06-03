extends Node2D
class_name Piece


@onready var queen = load("res://Scenes/queen.tscn")

enum moveType {
	NORMAL,
	CAPTURE,
	ENPASSANT,
	PROMOTION,
	CASTLE,
}

signal castle(newPos: Vector2i)
var moves: Dictionary
var boardPosition: Vector2i
var selected: bool
var colour: String
var board
var held: bool
var turn: bool
var canEnPassant: bool = false
var canBeEnPassanted: bool = false
var direction: int
var inCheck: bool = false
var timesMoved: int = 0
var whenEnPassant: int = 0 
var time: int = 0
signal piece_moved



func possible_moves(_enemyPieces: Array[Piece], _teamPieces: Array[Piece]) -> Dictionary:
	moves = {Vector2i(3, 2): moveType.NORMAL}
	return moves #make the moves



func _process(_delta: float) -> void:
	#if held == true and Input.is_action_pressed("click"):
		#global_position = get_global_mouse_position()
	#else:
	global_position = $"../../Board".get_tile_position(boardPosition)
	if selected == true:
		#make move and stuff
		pass

func connect_board(b):
	b.square_clicked.connect(_on_board_square_clicked)



func _on_board_square_clicked(square: Vector2i) -> void:
	if selected == false:
		if square == boardPosition:
			print(moves.keys())
			selected = true
			held = true
		else:
			selected = false
			held = false
	else:
		if get_parent().turn == true:
			for i in moves.keys():
				if i.x == square.x and i.y == square.y:
					boardPosition = square
					selected = false
					held = false
					timesMoved += 1
					if moves[i] == moveType.CASTLE:
						print("castled")
						if direction == -1:
							if boardPosition == Vector2i(6, 7):
								castle.emit(Vector2i(5, 7))
							elif boardPosition == Vector2i(2, 7):
								castle.emit(Vector2i(3, 7))
						if direction == 1:
							if boardPosition == Vector2i(6, 0):
								castle.emit(Vector2i(5, 0))
							elif boardPosition == Vector2i(2, 0):
								castle.emit(Vector2i(3, 0))
					piece_moved.emit()
		selected = false
		
static func slide( p: Vector2i, x: int, y: int, enemyPieces: Array[Piece], teamPieces: Array[Piece]) -> Dictionary:
	var newMoves: Dictionary
	var teamOnSquare: bool = false
	var enemyOnSquare: bool = false
	
	if p.x + x <= 7 and p.x + x >= 0 and p.y <= 7 and p.y >= 0:
		for piece in enemyPieces:
			if piece.boardPosition.x == p.x + x and piece.boardPosition.y == p.y + y:
				newMoves[Vector2i(p.x + x, p.y + y)] = moveType.CAPTURE
				enemyOnSquare = true
		for piece in teamPieces:
			if piece.boardPosition.x == p.x + x and piece.boardPosition.y == p.y + y:
				teamOnSquare = true
		if enemyOnSquare == false and teamOnSquare == false:
			newMoves[Vector2i(p.x + x, p.y + y)] = moveType.NORMAL
			newMoves.merge(slide(Vector2i(p.x + x, p.y + y), x, y, enemyPieces, teamPieces))
	return newMoves

static func goTo ( p: Vector2i, x: int, y: int, enemyPieces: Array[Piece], teamPieces: Array[Piece]) -> Dictionary:
	var newMove: Dictionary = {Vector2i(p.x + x, p.y + y): moveType.NORMAL}
	for piece in teamPieces:
		for newmove in newMove.keys():
			if piece.boardPosition.x == newmove.x and piece.boardPosition.y == newmove.y:
				var nothing: Dictionary
				return nothing
	for piece in enemyPieces:
		for newmove in newMove.keys():
			if piece.boardPosition.x == newmove.x and piece.boardPosition.y == newmove.y:
				newMove[newmove] = moveType.CAPTURE

	return newMove
