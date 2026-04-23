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
		
func _on_piece_moved():
	turn = false
	turn_over.emit()
