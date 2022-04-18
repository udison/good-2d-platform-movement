extends Node
class_name StateMachines

@onready var states = {
	StateBase.State.Idle: $Idle,
	StateBase.State.Walk: $Walk,
	StateBase.State.Jump: $Jump,
	StateBase.State.Fall: $Fall,
	StateBase.State.Attack: $Attack
}

var current_state: StateBase

func change_state(new_state: int):
	if current_state:
		current_state.exit()
		
	current_state = states[new_state]
	current_state.enter()
	print(current_state.name)

func init(player):
	for child in get_children():
		child.player = player
		
	change_state(StateBase.State.Idle)

func physics_process(delta: float):
	var new_state = current_state.physics_process(delta)
	if new_state != StateBase.State.Null:
		change_state(new_state)

func input(event: InputEvent):
	var new_state = current_state.input(event)
	if new_state != StateBase.State.Null:
		change_state(new_state)
