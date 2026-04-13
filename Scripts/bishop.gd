extends Piece


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	boardPosition = Vector2i(1, 1)
	selected = false
	print(boardPosition) # Replace with function body.
	possible_moves()
	board.square_clicked.connect(_on_board_square_clicked)



func possible_moves():
	print("it has been overridden")

func _on_board_square_clicked(square: Vector2i) -> void:
		if square == boardPosition:
			selected = true
			
