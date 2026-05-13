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
	var newMoves: Array
	newMoves.append_array(Piece.slide(boardPosition, -1, -1, enemyPieces, teamPieces))
	newMoves.append_array(Piece.slide(boardPosition, -1, 1, enemyPieces, teamPieces))
	newMoves.append_array(Piece.slide(boardPosition, 1, -1, enemyPieces, teamPieces))
	newMoves.append_array(Piece.slide(boardPosition, 1, 1, enemyPieces, teamPieces))
	return newMoves
