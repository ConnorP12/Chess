extends Node2D

@onready var bishop = preload("res://Scenes/bishop.tscn")
@onready var human = preload("res://Scenes/human.tscn")
var pieces: Array
var player = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = {"white": human.instantiate(), "black": human.instantiate()}
	for p in player.values():
		add_child(p)
	player["black"].piece.append(bishop.instantiate())
	player["black"].add_pieces()
	player["black"].piece[0].board = %Board
	player["black"].connect("square_clicked")
	
		




func _on_board_square_clicked(square: Vector2i) -> void:
	for piece in pieces:
		if square == piece.boardPosition:
			piece.selected = true
			break