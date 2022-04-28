extends StateBase

func input(event: InputEvent):
	if Input.is_action_just_pressed('jump'):
		state_manager.change_state(State.Jump)

	if Input.is_action_just_pressed('attack'):
		state_manager.change_state(State.Attack)
	
func physics_process(delta):
	# Moves the player
	player.move()
	
	# Player is falling
	if player.velocity.y > 0:
		state_manager.change_state(State.Fall)
	
	if player.velocity.x == 0:
		state_manager.change_state(State.Idle)
