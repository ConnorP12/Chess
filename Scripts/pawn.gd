extends Piece


func _process(_delta: float) -> void:
	super(_delta)
	$AnimatedSprite2D.play(colour)

func possible_moves(enemyPieces: Array[Piece], teamPieces: Array[Piece]) -> Array:
	var newMoves: Array
	if goTo(boardPosition, 0, direction, enemyPieces, teamPieces):
		newMoves.append(Vector2i(boardPosition.x, boardPosition.y + direction))
	if pawnJump(enemyPieces, teamPieces):
		newMoves.append(Vector2i(boardPosition.x, boardPosition.y + direction * 2))
	

	return newMoves

func pawnJump(enemyPieces: Array[Piece], teamPieces: Array[Piece]) -> bool:
	if timesMoved > 0:
		return false
	for piece in enemyPieces:
		if piece.boardPosition.x == boardPosition.x and piece.boardPosition.y == boardPosition.y + direction * 2:
			return false
		if piece.boardPosition.x == boardPosition.x and piece.boardPosition.y == boardPosition.y + direction:
			return false
	for piece in teamPieces:
		if piece.boardPosition.x == boardPosition.x and piece.boardPosition.y == boardPosition.y + direction * 2:
			return false
		if piece.boardPosition.x == boardPosition.x and piece.boardPosition.y == boardPosition.y + direction:
			return false
	return true
	
