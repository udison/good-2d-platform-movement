extends StateBase

var started_attack = false
var attack_count = 0
var anim_name = 'Attack1'

func enter():
	attack()

func physics_process(delta: float):
	player.velocity = Vector2.ZERO
	
	match attack_count:
		0:
			anim_name = 'Attack1'
		1:
			anim_name = 'Attack2'
		2:
			anim_name = 'Attack1'
		_:
			anim_name = 'Attack1'
			
	player.sword.get_node('HitArea').monitoring = player.attack_state == player.AttackStates.Attacking

	if Input.is_action_just_pressed('attack') and attack_count < 3 and player.attack_state == 2:
		attack()
	
	if player.attack_state == player.AttackStates.Null and started_attack:
		started_attack = false
		attack_count = 0
		anim_name = 'Attack1'
		return State.Walk
	
	started_attack = true
	return State.Null
	
func attack():
	player.anim_player.play(anim_name)
	attack_count += 1

func set_attack_state(state: int):
	print('Setting attack to ' + str(state))
	player.attack_state = state
