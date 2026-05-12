extends Piece


# Called when the node enters the scene tree for the first time.
func _process(_delta) -> void:
	super(_delta)
	$AnimatedSprite2D.play(colour)


#func possible_moves(enemyPieces: Array[Piece], teamPieces: Array[Piece]) -> Array:
	#pass