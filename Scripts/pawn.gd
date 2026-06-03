extends Piece


func _process(_delta: float) -> void:
	super(_delta)
	$AnimatedSprite2D.play(colour)

func possible_moves(enemyPieces: Array[Piece], teamPieces: Array[Piece]) -> Dictionary:
	canEnPassant = true
	var newMoves: Dictionary
	newMoves.merge(goTo(boardPosition, 0, direction, enemyPieces, teamPieces))
	newMoves.merge(pawnJump(enemyPieces, teamPieces))
	
	newMoves.merge(pawnCapture(enemyPieces))
	newMoves.merge(enPassant(enemyPieces))
	for move in newMoves.keys():
		if direction == 1 and move.y == 7:
			newMoves[move] = moveType.PROMOTION 
		elif direction == -1 and move.y == 0:
			newMoves[move] = moveType.PROMOTION 
	return newMoves

func pawnJump(enemyPieces: Array[Piece], teamPieces: Array[Piece]) -> Dictionary:
	var newMoves: Dictionary = {Vector2i(boardPosition.x, boardPosition.y + 2 * direction): moveType.NORMAL}
	var nothing: Dictionary
	if timesMoved > 0:
		return nothing
	for piece in enemyPieces:
		if piece.boardPosition.x == boardPosition.x and piece.boardPosition.y == boardPosition.y + direction * 2:
			return nothing
		if piece.boardPosition.x == boardPosition.x and piece.boardPosition.y == boardPosition.y + direction:
			return nothing
	for piece in teamPieces:
		if piece.boardPosition.x == boardPosition.x and piece.boardPosition.y == boardPosition.y + direction * 2:
			return nothing
		if piece.boardPosition.x == boardPosition.x and piece.boardPosition.y == boardPosition.y + direction:
			return nothing
	return newMoves
	
func pawnCapture(enemyPieces: Array[Piece]) -> Dictionary:
	var newMoves: Dictionary

	for piece in enemyPieces:
		if piece.boardPosition.x == boardPosition.x + 1 and piece.boardPosition.y == boardPosition.y + direction:
			newMoves[Vector2i(boardPosition.x + 1, boardPosition.y + direction)] = moveType.CAPTURE
		if piece.boardPosition.x == boardPosition.x + -1 and piece.boardPosition.y == boardPosition.y + direction:
			newMoves[Vector2i(boardPosition.x + -1, boardPosition.y + direction)] = moveType.CAPTURE

	return newMoves

func enPassant(enemyPieces: Array[Piece]) -> Dictionary:
	var newMoves: Dictionary
	
	if boardPosition.y == 4 and direction == 1:
		for piece in enemyPieces:
			if piece.canBeEnPassanted and piece.boardPosition.x == boardPosition.x + 1:
				newMoves[Vector2i(boardPosition.x + 1, boardPosition.y + direction)] = moveType.ENPASSANT
			if piece.canBeEnPassanted and piece.boardPosition.x == boardPosition.x - 1:
				newMoves[Vector2i(boardPosition.x - 1, boardPosition.y + direction)] = moveType.ENPASSANT
	if boardPosition.y == 3 and direction == -1:
		
		for piece in enemyPieces:
			if piece.canBeEnPassanted and piece.boardPosition.x == boardPosition.x + 1:
				newMoves[Vector2i(boardPosition.x + 1, boardPosition.y + direction)] = moveType.ENPASSANT
			if piece.canBeEnPassanted and piece.boardPosition.x == boardPosition.x - 1:
				newMoves[Vector2i(boardPosition.x - 1, boardPosition.y + direction)] = moveType.ENPASSANT

	return newMoves

static func goTo ( p: Vector2i, x: int, y: int, enemyPieces: Array[Piece], teamPieces: Array[Piece]) -> Dictionary:
	var newMove: Dictionary = {Vector2i(p.x + x, p.y + y): moveType.NORMAL}
	for piece in teamPieces:
		for newmove in newMove.keys():
			if piece.boardPosition.x == newmove.x and piece.boardPosition.y == newmove.y:
				var nothing: Dictionary
				return nothing
	for piece in enemyPieces:
		for newmove in newMove.keys():
			if piece.boardPosition.x == newmove.x and piece.boardPosition.y == newmove.y:
				var nothing: Dictionary
				return nothing

	return newMove
func _on_board_square_clicked(square: Vector2i) -> void:
	if selected == false:
		if square == boardPosition:
			print(moves.keys())
			selected = true
			held = true
		else:
			selected = false
			held = false
	else:
		print("turn not true")
		if get_parent().turn == true:
			print("turn is true")
			print("square clicked")
			for i in moves.keys():
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
					var delete: bool = false
					if moves[i] == moveType.PROMOTION:
						var player = get_parent()
						var newQueen = queen.instantiate()
						newQueen.boardPosition = square
						player.add_piece(newQueen)
						delete = true
					piece_moved.emit()
					if delete == true:
						queue_free()

					time += 1
		selected = false
