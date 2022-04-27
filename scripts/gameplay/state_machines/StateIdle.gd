extends StateBase

func physics_process(delta: float):
	var direction = Input.get_axis("left", "right")
	
	if direction:
		return State.Walk
		
	if Input.is_action_just_pressed("jump"):
		return State.Jump
		
	if Input.is_action_just_pressed("attack"):
		return State.Attack

	return State.Null
