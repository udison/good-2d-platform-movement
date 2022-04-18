extends StateBase

var started_attack = false

func physics_process(delta: float):
	# Moves the player
	player.move()
	
	if player.attack_state == player.AttackStates.Null and started_attack:
		started_attack = false
		return State.Idle
	
	started_attack = true
	return State.Null

func set_attack_state(state: int):
	print('Setting attack to ' + str(state))
	player.attack_state = state
