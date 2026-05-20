extends Piece


# Called when the node enters the scene tree for the first time.
func _process(_delta: float) -> void:
	super(_delta)
	$AnimatedSprite2D.play(colour)

func possible_moves(enemyPieces: Array[Piece], teamPieces: Array[Piece]) -> Array:
	var newMoves: Array

	if goTo(boardPosition, -1, -2,  enemyPieces, teamPieces): 
		newMoves.append(Vector2i(boardPosition.x + -1, boardPosition.y + -2))
	if goTo(boardPosition, 1, -2,  enemyPieces, teamPieces): 
		newMoves.append(Vector2i(boardPosition.x + 1, boardPosition.y + -2))
	if goTo(boardPosition, 2, -1,  enemyPieces, teamPieces): 
		newMoves.append(Vector2i(boardPosition.x + 2, boardPosition.y + -1))
	if goTo(boardPosition, 2, 1,  enemyPieces, teamPieces): 
		newMoves.append(Vector2i(boardPosition.x + 2, boardPosition.y + 1))
	if goTo(boardPosition, 1, 2,  enemyPieces, teamPieces): 
		newMoves.append(Vector2i(boardPosition.x + 1, boardPosition.y + 2))
	if goTo(boardPosition, -1, 2,  enemyPieces, teamPieces): 
		newMoves.append(Vector2i(boardPosition.x + -1, boardPosition.y + 2))
	if goTo(boardPosition, -2, 1,  enemyPieces, teamPieces): 
		newMoves.append(Vector2i(boardPosition.x + -2, boardPosition.y + 1))
	if goTo(boardPosition, -2, -1,  enemyPieces, teamPieces): 
		newMoves.append(Vector2i(boardPosition.x + -2, boardPosition.y + -1))
	return newMoves
