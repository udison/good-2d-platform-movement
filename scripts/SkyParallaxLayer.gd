extends ParallaxLayer

@export var CLOUD_SPEED: float = -2.0

func _process(delta):
	motion_offset.x += CLOUD_SPEED * delta
