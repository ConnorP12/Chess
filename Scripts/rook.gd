extends Piece


# Called when the node enters the scene tree for the first time.
func _process(_delta) -> void:
	super(_delta)
	$AnimatedSprite2D.play(colour)


func possible_moves(enemyPieces: Array[Piece], teamPieces: Array[Piece]) -> Dictionary:
	#move up
	#move down
	#move right
	#move left
	var newMoves: Dictionary
	newMoves.merge(Piece.slide(boardPosition, -1, 0, enemyPieces, teamPieces))
	newMoves.merge(Piece.slide(boardPosition, 1, 0, enemyPieces, teamPieces))
	newMoves.merge(Piece.slide(boardPosition, 0, 1, enemyPieces, teamPieces))
	newMoves.merge(Piece.slide(boardPosition, 0, -1, enemyPieces, teamPieces))
	return newMoves
