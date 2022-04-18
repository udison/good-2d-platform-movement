extends StateBase

func input(event: InputEvent):
	if player.jump_condition():
		return State.Jump
	
	return State.Null

func physics_process(delta):
	# Moves the player
	player.move()
	
	if player.is_on_floor():
		player.landed()
		return State.Idle

	return State.Null
