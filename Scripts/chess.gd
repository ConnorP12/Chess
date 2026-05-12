extends Node2D

 

@onready var bishop = preload("res://Scenes/bishop.tscn")
@onready var human = preload("res://Scenes/human.tscn")
@onready var rook = preload("res://Scenes/rook.tscn")
@onready var board = %Board
var player = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# add the two players
	player = {"white": human.instantiate(), "black": human.instantiate()}
	for p in player.keys():
		player[p].colour = p
	player["white"].turn_over.connect(_on_player_turn_over)
	player["black"].turn_over.connect(_on_player_turn_over)
	
	for p in player.values():
		add_child(p)
	# add a piece
	player["black"].piece.append(bishop.instantiate())
	player["white"].piece.append(rook.instantiate())
	player["white"].add_pieces()

	player["black"].add_pieces()
	# give each piece a reference to the board
	player["black"].piece[0].board = board
	player["white"].piece[0].board = board
	player["white"].piece[0].boardPosition.x = 5
	player["white"].piece[0].boardPosition.y = 4

	board.square_clicked.connect(player["black"].piece[0]._on_board_square_clicked)
	board.square_clicked.connect(player["white"].piece[0]._on_board_square_clicked)

	for piece in player["black"].piece:
		piece.moves = piece.possible_moves(player["white"].piece, player["black"].piece)
	
	player["white"].turn = not player["white"].turn
	for piece in player["white"].piece:
		piece.moves = piece.possible_moves(player["black"].piece, player["white"].piece)


	
func _on_player_turn_over() -> void:
	player["black"].turn = not player["black"].turn
	for piece in player["black"].piece:
		piece.moves = piece.possible_moves(player["white"].piece, player["black"].piece)
		if player["black"].turn == true:
			for enemyPiece in player["white"].piece:
				if piece.boardPosition == enemyPiece.boardPosition:
					player["black"].piece.erase(piece)
					piece.queue_free()
	
	player["white"].turn = not player["white"].turn
	for piece in player["white"].piece:
		piece.moves = piece.possible_moves(player["black"].piece, player["white"].piece)
		if player["white"].turn == true:
			for enemyPiece in player["black"].piece:
				if piece.boardPosition == enemyPiece.boardPosition:
					player["white"].piece.erase(piece)
					piece.queue_free()
	
