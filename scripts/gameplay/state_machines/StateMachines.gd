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

func init(player):
	for child in get_children():
		child.player = player
		child.state_manager = self
		
	change_state(StateBase.State.Idle)

func change_state(new_state: int):
	var state = states[new_state]
	
	if !state.can_enter():
		return
	
	if current_state:
		current_state.exit()
		
	current_state = state
	print(current_state.name)
	current_state.enter()

func physics_process(delta: float):
	current_state.physics_process(delta)

func input(event: InputEvent):
	current_state.input(event)
