extends Node2D
class_name Player

var piece: Array[Piece]
var colour: String
var turn: bool

func add_pieces() -> void:
	for p in piece:
		add_child(p)