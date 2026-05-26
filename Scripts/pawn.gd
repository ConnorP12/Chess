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
	
	newMoves.append_array(pawnCapture(enemyPieces))
	newMoves.append_array(enPassant(enemyPieces))
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
	
func pawnCapture(enemyPieces: Array[Piece]) -> Array:
	var newMoves: Array

	for piece in enemyPieces:
		if piece.boardPosition.x == boardPosition.x + 1 and piece.boardPosition.y == boardPosition.y + direction:
			newMoves.append(Vector2i(boardPosition.x + 1, boardPosition.y + direction))
		if piece.boardPosition.x == boardPosition.x + -1 and piece.boardPosition.y == boardPosition.y + direction:
			newMoves.append(Vector2i(boardPosition.x + -1, boardPosition.y + direction))

	return newMoves

func enPassant(enemyPieces: Array[Piece]) -> Array:
	var newMoves: Array
	
	if boardPosition.y == 4 and direction == 1:
		for piece in enemyPieces:
			if piece.canBeEnPassanted and piece.boardPosition.x == boardPosition.x + 1:
				newMoves.append(Vector2i(boardPosition.x + 1, boardPosition.y + direction))
			if piece.canBeEnPassanted and piece.boardPosition.x == boardPosition.x - 1:
				newMoves.append(Vector2i(boardPosition.x - 1, boardPosition.y + direction))
	if boardPosition.y == 3 and direction == -1:
		
		for piece in enemyPieces:
			print(piece.canBeEnPassanted)
			if piece.canBeEnPassanted and piece.boardPosition.x == boardPosition.x + 1:
				newMoves.append(Vector2i(boardPosition.x + 1, boardPosition.y + direction))
			if piece.canBeEnPassanted and piece.boardPosition.x == boardPosition.x - 1:
				newMoves.append(Vector2i(boardPosition.x - 1, boardPosition.y + direction))

	return newMoves
func _on_board_square_clicked(square: Vector2i) -> void:
	if selected == false:
		if square == boardPosition:
			selected = true
			held = true
		else:
			selected = false
			held = false
	else:
		if turn == true:
			for i in moves:
				if i.x == square.x and i.y == square.y:
					boardPosition = square
					selected = false
					held = false
					timesMoved += 1
					if boardPosition.y == 4 and direction == -1:
						canBeEnPassanted = true
						whenEnPassant = time
					elif boardPosition.y == 3 and direction == 1:
						canBeEnPassanted = true
						whenEnPassant = time
					piece_moved.emit()
					time += 1
		selected = false
