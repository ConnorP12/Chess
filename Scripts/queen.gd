extends Piece


func _process(_delta) -> void:
	super(_delta)
	$AnimatedSprite2D.play(colour)


func possible_moves(enemyPieces: Array[Piece], teamPieces: Array[Piece]) -> Array:
	var newMoves: Array
	newMoves.append_array(Piece.slide(boardPosition, -1, 0, enemyPieces, teamPieces))
	newMoves.append_array(Piece.slide(boardPosition, 1, 0, enemyPieces, teamPieces))
	newMoves.append_array(Piece.slide(boardPosition, 0, 1, enemyPieces, teamPieces))
	newMoves.append_array(Piece.slide(boardPosition, 0, -1, enemyPieces, teamPieces))
	newMoves.append_array(Piece.slide(boardPosition, -1, -1, enemyPieces, teamPieces))
	newMoves.append_array(Piece.slide(boardPosition, -1, 1, enemyPieces, teamPieces))
	newMoves.append_array(Piece.slide(boardPosition, 1, -1, enemyPieces, teamPieces))
	newMoves.append_array(Piece.slide(boardPosition, 1, 1, enemyPieces, teamPieces))
	return newMoves