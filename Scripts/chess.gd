extends Node2D

@onready var bishop = preload("res://Scenes/bishop.tscn")
@onready var human = preload("res://Scenes/human.tscn")
@onready var board = %Board
var pieces: Array
var player = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# add the two players
	player = {"white": human.instantiate(), "black": human.instantiate()}
	for p in player.values():
		add_child(p)
	# add a piece
	player["black"].piece.append(bishop.instantiate())
	player["black"].add_pieces()
	# give each piece a reference to the board
	player["black"].piece[0].board = board
	board.square_clicked.connect(player["black"].piece[0]._on_board_square_clicked)
	
		
