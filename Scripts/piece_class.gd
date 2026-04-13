extends Node2D
class_name Piece

var moves: Array[Vector2i]
var boardPosition: Vector2i
var selected: bool
var colour: String
var board


func possible_moves():
	print("override this function")



func _process(_delta: float) -> void:
	if selected:
		global_position = get_global_mouse_position()
	else:
		global_position = board.get_tile_position(boardPosition)