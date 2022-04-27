extends StateBase

func enter():
	super.enter()
	
	# Handle Jump
	if player.jump_condition():
		player.jump()
		return State.Jump
		
	return State.Null

func physics_process(delta):
	# Moves the player
	player.move()
	
	# Handle Jump
	if Input.is_action_just_pressed('jump') and player.jump_condition():
		player.jump()
		return State.Null

	# Player is falling
	if player.velocity.y > 0:
		return State.Fall
		
	if player.is_on_floor():
		player.landed()
		return State.Walk
	
	return State.Null
