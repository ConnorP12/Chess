extends Node2D
class_name Player

var piece: Array[Piece]
var colour: String
var turn: bool
signal turn_over

func add_pieces() -> void:
	for p in piece:
		add_child(p)
		p.piece_moved.connect(_on_piece_moved)
		p.colour = colour
		

func makePiece(newPiece: Piece, x: int, y: int) -> Piece:
	newPiece.boardPosition = Vector2i(x, y)
	newPiece.piece_moved.connect(_on_piece_moved)
	newPiece.colour = colour




func _on_piece_moved():
		
		turn_over.emit()
