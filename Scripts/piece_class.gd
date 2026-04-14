extends Node2D
class_name Piece

var moves: Array[Vector2i]
var boardPosition: Vector2i
var selected: bool
var colour: String
var board
var held: bool

func possible_moves():
	print("override this function")



func _process(_delta: float) -> void:
	if held == true and Input.is_action_pressed("click"):
		global_position = get_global_mouse_position()
	else:
		global_position = board.get_tile_position(boardPosition)


func _on_board_square_clicked(_square: Vector2i) -> void:
	pass
