extends Piece


func _ready() -> void:
	selected = false

func _process(_delta: float) -> void:
	super(_delta)
	$AnimatedSprite2D.play(colour)

func possible_moves(enemyPieces: Array[Piece], teamPieces: Array[Piece]) -> Dictionary:
	var newMoves: Dictionary
	newMoves.merge(goTo(boardPosition, -1, -1, enemyPieces, teamPieces))
	newMoves.merge(goTo(boardPosition, 0, -1, enemyPieces, teamPieces))
	newMoves.merge(goTo(boardPosition, 1, -1, enemyPieces, teamPieces))
	newMoves.merge(goTo(boardPosition, -1, 0, enemyPieces, teamPieces))
	newMoves.merge(goTo(boardPosition, 1, 0, enemyPieces, teamPieces))
	newMoves.merge(goTo(boardPosition, -1, 1, enemyPieces, teamPieces))
	newMoves.merge(goTo(boardPosition, 0, 1, enemyPieces, teamPieces))
	newMoves.merge(goTo(boardPosition, 1, 1, enemyPieces, teamPieces))
	newMoves.merge(doCastle(enemyPieces, teamPieces))
	return newMoves

func doCastle(enemyPieces: Array[Piece], teamPieces: Array[Piece]) -> Dictionary:
	var newMoves: Dictionary
	if direction == -1 and boardPosition == Vector2i(4, 7) and timesMoved == 0:
		for teamPiece in teamPieces:
			if teamPiece.boardPosition == Vector2i(7, 7) and teamPiece.timesMoved == 0:
				var canCastle = true
				for otherPiece in teamPieces:
					if otherPiece.boardPosition == Vector2i(5, 7) or otherPiece.boardPosition == Vector2i(6, 7):
						canCastle = false
				for otherPiece in enemyPieces:
					if otherPiece.boardPosition == Vector2i(5, 7) or otherPiece.boardPosition == Vector2i(6, 7):
						canCastle = false
					for move in otherPiece.moves.keys():
						if move == Vector2i(5, 7) or move == Vector2i(6, 7) or move == Vector2i(4, 7):
							canCastle = false
				if canCastle == true:
					newMoves[Vector2i(6, 7)] = moveType.CASTLE

	if direction == -1 and boardPosition == Vector2i(4, 7) and timesMoved == 0:
		for teamPiece in teamPieces:
			if teamPiece.boardPosition == Vector2i(0, 7) and teamPiece.timesMoved == 0:
				var canCastle = true
				for otherPiece in teamPieces:
					if otherPiece.boardPosition == Vector2i(2, 7) or otherPiece.boardPosition == Vector2i(3, 7):
						canCastle = false
				for otherPiece in enemyPieces:
					if otherPiece.boardPosition == Vector2i(2, 7) or otherPiece.boardPosition == Vector2i(3, 7):
						canCastle = false
					for move in otherPiece.moves.keys():
						if move == Vector2i(2, 7) or move == Vector2i(3, 7) or move == Vector2i(4, 7):
							canCastle = false
				if canCastle == true:
					newMoves[Vector2i(2, 7)] = moveType.CASTLE
	if direction == 1 and boardPosition == Vector2i(4, 0) and timesMoved == 0:
		for teamPiece in teamPieces:
			if teamPiece.boardPosition == Vector2i(7, 0) and teamPiece.timesMoved == 0:
				var canCastle = true
				for otherPiece in teamPieces:
					if otherPiece.boardPosition == Vector2i(5, 0) or otherPiece.boardPosition == Vector2i(6, 0):
						canCastle = false
				for otherPiece in enemyPieces:
					if otherPiece.boardPosition == Vector2i(5, 0) or otherPiece.boardPosition == Vector2i(6, 0):
						canCastle = false
					for move in otherPiece.moves.keys():
						if move == Vector2i(5, 0) or move == Vector2i(6, 0) or move == Vector2i(4, 0):
							canCastle = false
				if canCastle == true:
					newMoves[Vector2i(6, 0)] = moveType.CASTLE

	if direction == 1 and boardPosition == Vector2i(4, 0) and timesMoved == 0:
		for teamPiece in teamPieces:
			if teamPiece.boardPosition == Vector2i(0, 0) and teamPiece.timesMoved == 0:
				var canCastle = true
				for otherPiece in teamPieces:
					if otherPiece.boardPosition == Vector2i(2, 0) or otherPiece.boardPosition == Vector2i(3, 0):
						canCastle = false
				for otherPiece in enemyPieces:
					if otherPiece.boardPosition == Vector2i(2, 0) or otherPiece.boardPosition == Vector2i(3, 0):
						canCastle = false
					for move in otherPiece.moves.keys():
						if move == Vector2i(2, 0) or move == Vector2i(3, 0) or move == Vector2i(4, 0):
							canCastle = false
				if canCastle == true:
					newMoves[Vector2i(2, 0)] = moveType.CASTLE


	return newMoves
