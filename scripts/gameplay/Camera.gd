extends Camera2D

@onready var world = get_tree().get_current_scene()
@onready var player = world.get_node('Player')

func _ready():
	limit_left = world.CAMERA_MIN_X
	limit_right = world.CAMERA_MAX_X

func _process(delta):
	global_position.x = player.global_position.x
