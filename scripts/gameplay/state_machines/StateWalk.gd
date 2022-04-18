extends StateBase

func input(event: InputEvent):
	if Input.is_action_just_pressed('jump'):
		return State.Jump

	if Input.is_action_just_pressed('attack'):
		return State.Attack
		
	return State.Null
	
func physics_process(delta):
	# Moves the player
	player.move()
	

	# Player is falling
	if player.velocity.y > 0:
		return State.Fall
	
	if player.velocity.x == 0:
		return State.Idle
	
	return State.Null
