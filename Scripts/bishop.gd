extends Piece



@onready var bishop = preload("res://Scenes/bishop.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selected = false

func _process(_delta: float) -> void:
	super(_delta)
	$AnimatedSprite2D.play(colour)

 

func possible_moves(enemyPieces: Array[Piece], teamPieces: Array[Piece]) -> Dictionary:
	var newMoves: Dictionary
	newMoves.merge(Piece.slide(boardPosition, -1, -1, enemyPieces, teamPieces))
	newMoves.merge(Piece.slide(boardPosition, -1, 1, enemyPieces, teamPieces))
	newMoves.merge(Piece.slide(boardPosition, 1, -1, enemyPieces, teamPieces))
	newMoves.merge(Piece.slide(boardPosition, 1, 1, enemyPieces, teamPieces))
	return newMoves
