extends Node
class_name StateBase

var player: Player
var state_manager: StateMachines

enum State {
	Null,
	Idle,
	Walk,
	Jump,
	Fall,
	Attack
}

@export var animation_name: String

func can_enter():
	return true

func enter():
	player.anim_player.play(animation_name)

func exit():
	pass

func input(event: InputEvent):
	pass

func process(delta: float):
	pass

func physics_process(delta: float):
	pass
