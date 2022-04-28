extends StateBase

func input(event: InputEvent):
	if Input.is_action_just_pressed('jump'):
		state_manager.change_state(State.Jump)

func physics_process(delta):
	# Moves the player
	player.move()
	
	if player.is_on_floor():
		state_manager.change_state(State.Walk)
