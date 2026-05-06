extends Piece


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	boardPosition = Vector2i(2, 1)
	selected = false
	moves.append(Vector2i(1, 1))

func _process(_delta: float) -> void:
	super(_delta)
	$AnimatedSprite2D.play(colour)



func possible_moves(enemyPieces: Array[Piece], teamPieces: Array[Piece]) -> Array:
	var move: Array
	var newPosition: Vector2i = Vector2i(boardPosition)
	var enemyPieceOnPosition := false
	var teamPieceOnPosition := false
	while newPosition.x < 7 and newPosition.y < 7:
		newPosition.x += 1
		newPosition.y += 1
		for enemyPiece in enemyPieces:
			if enemyPiece.boardPosition == newPosition:
				enemyPieceOnPosition = true
		for teamPiece in teamPieces:
			if teamPiece.boardPosition == newPosition:
				teamPieceOnPosition = true
		if enemyPieceOnPosition == true:
			move.append(newPosition)
			break
		elif teamPieceOnPosition == true:
			break
		else:
			move.append(newPosition)

	
	newPosition = Vector2i(boardPosition)
	enemyPieceOnPosition = false
	teamPieceOnPosition = false
	while newPosition.x > 0 and newPosition.y > 0:
		newPosition.x -= 1
		newPosition.y -= 1
		for enemyPiece in enemyPieces:
			if enemyPiece.boardPosition == newPosition:
				enemyPieceOnPosition = true
		for teamPiece in teamPieces:
			if teamPiece.boardPosition == newPosition:
				teamPieceOnPosition = true
		if enemyPieceOnPosition == true:
			move.append(newPosition)
			break
		elif teamPieceOnPosition == true:
			break
		else:
			move.append(newPosition)
	newPosition = Vector2i(boardPosition)
	enemyPieceOnPosition = false
	teamPieceOnPosition = false
	while newPosition.x > 0 and newPosition.y < 7:
		newPosition.x -= 1
		newPosition.y += 1
		for enemyPiece in enemyPieces:
			if enemyPiece.boardPosition == newPosition:
				enemyPieceOnPosition = true
		for teamPiece in teamPieces:
			if teamPiece.boardPosition == newPosition:
				teamPieceOnPosition = true
		if enemyPieceOnPosition == true:
			move.append(newPosition)
			break
		elif teamPieceOnPosition == true:
			break
		else:
			move.append(newPosition)
	newPosition = Vector2i(boardPosition)
	enemyPieceOnPosition = false
	teamPieceOnPosition = false
	while newPosition.x < 7 and newPosition.y > 0:
		newPosition.x += 1
		newPosition.y -= 1
		for enemyPiece in enemyPieces:
			if enemyPiece.boardPosition == newPosition:
				enemyPieceOnPosition = true
		for teamPiece in teamPieces:
			if teamPiece.boardPosition == newPosition:
				teamPieceOnPosition = true
		if enemyPieceOnPosition == true:
			move.append(newPosition)
			break
		elif teamPieceOnPosition == true:
			break
		else:
			move.append(newPosition)
	return move
