extends Node2D
class_name Player

var piece: Array[Piece]
var king: Piece
var colour: String
var turn: bool
var direction: int
signal turn_over

func add_pieces() -> void:
	print("adding")
	for child in get_children():
		queue_free()
	for p in piece:
		if p.get_parent():
			p.get_parent().remove_child(p)
		add_child(p)
		p.piece_moved.connect(_on_piece_moved)
		p.colour = colour
		p.direction = direction

func add_piece(newPiece):
	piece.append(newPiece)
	add_child(newPiece)
	newPiece.piece_moved.connect(_on_piece_moved)
	newPiece.colour = colour
	newPiece.turn = turn
	newPiece.direction = direction

func _on_piece_moved():
	for p in piece:
		if p.canBeEnPassanted and p.whenEnPassant != p.time:
			p.canBeEnPassanted = false
	turn_over.emit()

func legal_moves(enemyPieces: Array[Piece]) -> void:
	for p in piece:
		for move in p.moves.keys():
			if move.x > 7 or move.x < 0 or move.y > 7 or move.y < 0:
				p.moves.erase(move)
		for move in p.moves.keys():
			var oldX = p.boardPosition.x
			var oldY = p.boardPosition.y
			p.boardPosition.x = move.x
			p.boardPosition.y = move.y
			var enemyMoves: Dictionary
			for enemyPiece in enemyPieces:
				if enemyPiece.boardPosition != p.boardPosition:
					enemyMoves.merge(enemyPiece.possible_moves(piece, enemyPieces))
			if enemyMoves.has(king.boardPosition):
				p.moves.erase(move)
			p.boardPosition.x = oldX
			p.boardPosition.y = oldY
func _on_castle(newPos: Vector2i) -> void:
	print("castled")
	for p in piece:
		if newPos == Vector2i(5, 7) and p.boardPosition == Vector2i(7, 7):
			p.boardPosition = newPos
		if newPos == Vector2i(3, 7) and p.boardPosition == Vector2i(0, 7):
			p.boardPosition = newPos
		if newPos == Vector2i(5, 0) and p.boardPosition == Vector2i(7, 0):
			p.boardPosition = newPos
		if newPos == Vector2i(3, 0) and p.boardPosition == Vector2i(0, 0):
			p.boardPosition = newPos
