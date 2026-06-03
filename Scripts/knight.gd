extends Piece


# Called when the node enters the scene tree for the first time.
func _process(_delta: float) -> void:
	super(_delta)
	$AnimatedSprite2D.play(colour)

func possible_moves(enemyPieces: Array[Piece], teamPieces: Array[Piece]) -> Dictionary:
	var newMoves: Dictionary

	newMoves.merge(goTo(boardPosition, -1, -2,  enemyPieces, teamPieces))
	newMoves.merge(goTo(boardPosition, 1, -2,  enemyPieces, teamPieces))
	newMoves.merge(goTo(boardPosition, 2, -1,  enemyPieces, teamPieces)) 
	newMoves.merge(goTo(boardPosition, 2, 1,  enemyPieces, teamPieces))
	newMoves.merge(goTo(boardPosition, 1, 2,  enemyPieces, teamPieces)) 
	newMoves.merge(goTo(boardPosition, -1, 2,  enemyPieces, teamPieces))
	newMoves.merge(goTo(boardPosition, -2, 1,  enemyPieces, teamPieces)) 
	newMoves.merge(goTo(boardPosition, -2, -1,  enemyPieces, teamPieces))
	return newMoves
