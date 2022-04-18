extends StateBase

func input(event: InputEvent):
	if Input.is_action_just_pressed('attack'):
		return State.Attack
		
	return State.Null

func physics_process(delta):
	# Moves the player
	player.move()

	# Handle Jump
	if player.jump_condition():
		player.jump()
		return State.Null

	# Player is falling
	if player.velocity.y > 0:
		return State.Fall
	
	return State.Null
