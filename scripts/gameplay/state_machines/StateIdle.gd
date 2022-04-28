extends StateBase

func physics_process(delta: float):
	var direction = Input.get_axis("left", "right")
	
	if direction:
		state_manager.change_state(State.Walk)
		
	if Input.is_action_just_pressed("jump"):
		state_manager.change_state(State.Jump)
		
	if Input.is_action_just_pressed("attack"):
		state_manager.change_state(State.Attack)
