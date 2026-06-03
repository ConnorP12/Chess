extends Node2D

 

@onready var game_over_menu = $GameOverMenu
@onready var bishop = preload("res://Scenes/bishop.tscn")
@onready var human = preload("res://Scenes/human.tscn")
@onready var rook = preload("res://Scenes/rook.tscn")
@onready var queen = preload("res://Scenes/queen.tscn")
@onready var knight = preload("res://Scenes/knight.tscn")
@onready var pawn = preload("res://Scenes/pawn.tscn")
@onready var king = preload("res://Scenes/king.tscn")
@onready var board = %Board
var player = {}
# Called when the node enters the scene tree for the first time.
func cheese() -> void:
	# add the two players
	player = {"white": human.instantiate(), "black": human.instantiate()}
	for p in player.keys():
		player[p].colour = p
	player["white"].turn_over.connect(_on_player_turn_over)
	player["black"].turn_over.connect(_on_player_turn_over)
	player["white"].direction = -1
	player["black"].direction = 1
	
	for p in player.values():
		add_child(p)
	# add a piece
	player["black"].piece.append(pawn.instantiate())
	player["black"].piece.append(pawn.instantiate())
	player["white"].piece.append(pawn.instantiate())
	player["white"].add_pieces()

	player["black"].add_pieces()
	# give each piece a reference to the board
	player["black"].piece[0].board = board
	player["black"].piece[1].board = board
	player["white"].piece[0].board = board
	player["black"].piece[1].boardPosition.x = 0
	player["black"].piece[1].boardPosition.y = 0
	player["black"].piece[0].boardPosition.x = 4
	player["black"].piece[0].boardPosition.y = 0 
	player["white"].piece[0].boardPosition = Vector2i(7, 6)

	board.square_clicked.connect(player["white"].piece[0]._on_board_square_clicked)

	for piece in player["black"].piece:
		piece.moves = piece.possible_moves(player["white"].piece, player["black"].piece)
		piece.turn = false
	
	player["white"].turn = not player["white"].turn
	for piece in player["white"].piece:
		piece.moves = piece.possible_moves(player["black"].piece, player["white"].piece)
		piece.turn = true
func _ready() -> void:
	player = start_game()
	for p in player.values():
		add_child(p)


	
func _on_player_turn_over() -> void:
	print(player["black"].piece.size())
	for p in player.values():
		var number = 0
		for pece in p.piece:
			number += 1
			p.piece = p.piece.filter(func(pece): return is_instance_valid(pece))
		for pece in p.piece:
			pece.board = board
			pece.connect_board(board)

	player["white"].king.castle.connect(player["white"]._on_castle)
	player["black"].king.castle.connect(player["black"]._on_castle)
	player["black"].turn = not player["black"].turn
	for piece in player["black"].piece:
		piece.turn = player["black"].turn
		piece.moves = piece.possible_moves(player["white"].piece, player["black"].piece)
		if player["black"].turn == true:
			for enemyPiece in player["white"].piece:
				if piece.boardPosition == enemyPiece.boardPosition:
					player["black"].piece.erase(piece)
					piece.queue_free()
				elif enemyPiece.canEnPassant and piece.boardPosition.x == enemyPiece.boardPosition.x and piece.boardPosition.y == enemyPiece.boardPosition.y - enemyPiece.direction and piece.canBeEnPassanted:
					player["black"].piece.erase(piece)
					piece.queue_free()
			for teamPiece in player["white"].piece:
				if teamPiece.timesMoved == 0:
					var otherPieces = player["white"].piece.duplicate()
					otherPieces.erase(teamPiece)
					for otherPiece in otherPieces:
						if otherPiece.boardPosition == teamPiece.boardPosition:
							player["white"].piece.erase(otherPiece)
							otherPiece.queue_free()
	
	player["white"].turn = not player["white"].turn
	for piece in player["white"].piece:
		piece.turn = player["white"].turn
		if player["white"].turn == true:
			for enemyPiece in player["black"].piece:
				if piece.boardPosition == enemyPiece.boardPosition:
					player["white"].piece.erase(piece)
					piece.queue_free()
				elif enemyPiece.canEnPassant and piece.boardPosition.x == enemyPiece.boardPosition.x and piece.boardPosition.y == enemyPiece.boardPosition.y - enemyPiece.direction and piece.canBeEnPassanted:
					player["black"].piece.erase(piece)
					piece.queue_free()
	
			for teamPiece in player["black"].piece:
				if teamPiece.timesMoved == 0:
					var otherPieces = player["black"].piece.duplicate()
					otherPieces.erase(teamPiece)
					for otherPiece in otherPieces:
						if otherPiece.boardPosition == teamPiece.boardPosition:
							player["black"].piece.erase(otherPiece)
							otherPiece.queue_free()
	for piece in player["white"].piece:
		piece.moves = piece.possible_moves(player["black"].piece, player["white"].piece)
	if player["white"].turn == true:
		player["white"].legal_moves(player["black"].piece)
	for piece in player["black"].piece:
		piece.moves = piece.possible_moves(player["white"].piece, player["black"].piece)
	if player["black"].turn == true:
		player["black"].legal_moves(player["white"].piece)
	var totalMoves = 0
	if player["white"].turn == true:
		for p in player["white"].piece:
			totalMoves += p.moves.size()
		if totalMoves == 0:
			var checkmate: bool = false
			for p in player["black"].piece:
				for move in p.moves.keys():
					if move == player["white"].king.boardPosition:
						checkmate = true
						game_over_menu.show_game_over("noir gagne")
			if checkmate == false:
				game_over_menu.show_game_over("match nul")
	else:
		for p in player["black"].piece:
			totalMoves += p.moves.size()
		if totalMoves == 0:
			var checkmate: bool = false
			for p in player["white"].piece:
				for move in p.moves.keys():
					if move == player["black"].king.boardPosition:
						game_over_menu.show_game_over("blanc gagne")
						checkmate = true
			if checkmate == false:
				game_over_menu.show_game_over("match nul")
	


func start_game() -> Dictionary:
	var newGame: Dictionary

	newGame = {"white": human.instantiate(), "black": human.instantiate()}
	for p in newGame.keys():
		newGame[p].colour = p
	newGame["white"].turn_over.connect(_on_player_turn_over)
	newGame["black"].turn_over.connect(_on_player_turn_over)
	newGame["white"].direction = -1
	newGame["black"].direction = 1

	newGame["white"].piece.append(rook.instantiate())
	newGame["white"].piece[0].boardPosition = Vector2i(0, 7)
	newGame["white"].piece.append(knight.instantiate())
	newGame["white"].piece[1].boardPosition = Vector2i(1, 7)
	newGame["white"].piece.append(bishop.instantiate())
	newGame["white"].piece[2].boardPosition = Vector2i(2, 7)
	newGame["white"].piece.append(queen.instantiate())
	newGame["white"].piece[3].boardPosition = Vector2i(3, 7)
	var whiteKing: Piece = king.instantiate()
	whiteKing.boardPosition = Vector2i(4, 7)
	newGame["white"].king = whiteKing
	newGame["white"].piece.append(whiteKing)
	whiteKing.castle.connect(newGame["white"]._on_castle)
	newGame["white"].piece.append(rook.instantiate())
	newGame["white"].piece[5].boardPosition = Vector2i(7, 7)
	newGame["white"].piece.append(knight.instantiate())
	newGame["white"].piece[6].boardPosition = Vector2i(6, 7)
	newGame["white"].piece.append(bishop.instantiate())
	newGame["white"].piece[7].boardPosition = Vector2i(5, 7)

	newGame["black"].piece.append(rook.instantiate())
	newGame["black"].piece[0].boardPosition = Vector2i(0, 0)
	newGame["black"].piece.append(knight.instantiate())
	newGame["black"].piece[1].boardPosition = Vector2i(1, 0)
	newGame["black"].piece.append(bishop.instantiate())
	newGame["black"].piece[2].boardPosition = Vector2i(2, 0)
	newGame["black"].piece.append(queen.instantiate())
	newGame["black"].piece[3].boardPosition = Vector2i(3, 0)
	var blackKing: Piece = king.instantiate()
	blackKing.boardPosition = Vector2i(4, 0)
	newGame["black"].king = blackKing
	newGame["black"].piece.append(blackKing)
	blackKing.castle.connect(newGame["black"]._on_castle)
	newGame["black"].piece.append(rook.instantiate())
	newGame["black"].piece[5].boardPosition = Vector2i(7, 0)
	newGame["black"].piece.append(knight.instantiate())
	newGame["black"].piece[6].boardPosition = Vector2i(6, 0)
	newGame["black"].piece.append(bishop.instantiate())
	newGame["black"].piece[7].boardPosition = Vector2i(5, 0)
	for i in range(8):
		var whitePawn: Piece = pawn.instantiate()
		whitePawn.boardPosition = Vector2i(i, 6)
		newGame["white"].piece.append(whitePawn)
		var blackPawn: Piece = pawn.instantiate()
		blackPawn.boardPosition = Vector2i(i, 1)
		newGame["black"].piece.append(blackPawn)
	newGame["white"].add_pieces()
	newGame["black"].add_pieces()
	
	for p in newGame["white"].piece:
		board.square_clicked.connect(p._on_board_square_clicked)
	for p in newGame["black"].piece:
		board.square_clicked.connect(p._on_board_square_clicked)

	for piece in newGame["black"].piece:
		piece.moves = piece.possible_moves(newGame["white"].piece, newGame["black"].piece)
		piece.turn = false
	
	newGame["white"].turn = not newGame["white"].turn
	for piece in newGame["white"].piece:
		piece.moves = piece.possible_moves(newGame["black"].piece, newGame["white"].piece)
		piece.turn = true
	return newGame
