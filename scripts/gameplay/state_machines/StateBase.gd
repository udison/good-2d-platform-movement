extends Node
class_name StateBase

var player: Player

enum State {
	Null,
	Idle,
	Walk,
	Jump,
	Fall,
	Attack
}

@export var animation_name: String

func enter():
	player.anim_player.play(animation_name)

func exit():
	pass

func input(event: InputEvent):
	return State.Null

func process(delta: float):
	return State.Null

func physics_process(delta: float):
	return State.Null
