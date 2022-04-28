extends StateBase

func can_enter():
	return player.is_on_floor() || player.jump_count < 2

func enter():
	super.enter()
	player.jump()
	
func input(event: InputEvent):
	# Handle Jump
	if Input.is_action_just_pressed('jump'):
		state_manager.change_state(State.Jump)

func physics_process(delta):
	# Moves the player
	player.move()

	# Player is falling
	if player.velocity.y > 0:
		state_manager.change_state(State.Fall)
		
	if player.is_on_floor():
		state_manager.change_state(State.Walk)
