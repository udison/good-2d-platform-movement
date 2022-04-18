extends CharacterBody2D

class_name Player

@export var speed: float = 80.0

# Combat
@export var light_damage: float = 25
@export var light_damage_seq_mult: float = 1.3

enum AttackStates {
	Null,
	Attacking,
	Resting
}
var attack_state: int = AttackStates.Null

# Jump Stuff
@export var jump_height: float = 50
@export var jump_time_to_peak: float = 2.5
@export var jump_time_to_descent: float = 2.5
@export var mid_air_deceleration: float = 15.0

@onready var jump_velocity: float = ((2.0 * jump_height) * jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * jump_height) * (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * jump_height) * (jump_time_to_descent * jump_time_to_descent)) * -1

# Particles
@export var land_particle: PackedScene
@export var jump_particle: PackedScene
@export var double_jump_particle: PackedScene

var facing_right: bool = true
var can_jump: bool = true
var jump_count: int = 0
var landing: bool = false

@onready var sprite: Sprite2D = $Sprite
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var feet: Node2D = $Feet
@onready var right_hand: Node2D = $RightHand
@onready var left_hand: Node2D = $LeftHand
@onready var states: StateMachines = $StateMachines

func _ready():
	states.init(self)
	
func _unhandled_input(event):
	states.input(event)

func _physics_process(delta):
	# Add the gravity
	if not is_on_floor():
		velocity.y += get_gravity() * delta
		
		if !landing:
			landing = true
	
	# Flips the player
	handle_horizontal_flip()
	
	states.physics_process(delta)
	
	move_and_slide()
	return
	
func get_gravity():
	# When jump is released before jump height is reached
	if Input.is_action_just_released('jump') and velocity.y < 0:
		return fall_gravity * (abs(velocity.y) / abs(jump_velocity) * mid_air_deceleration)
	
	return jump_gravity if velocity.y < 0 else fall_gravity

func handle_horizontal_flip():
	if velocity.x > 0 and not facing_right: 
		facing_right = true
		scale.x = -1
	elif velocity.x < 0 and facing_right:
		facing_right = false
		scale.x = -1

func landed():
	if landing:
		can_jump = true
		jump_count = 0
		spawn_feet_particles(land_particle)
		landing = false
		
func move():
	velocity.x = get_horizontal_movement()

func get_horizontal_movement():
	var direction = Input.get_axis("left", "right")
	
	if direction:
		return direction * speed
	else:
		return move_toward(velocity.x, 0, speed)

func jump():
	if can_jump:
		jump_count += 1
		velocity.y = jump_velocity
		
		if jump_count == 1:
			spawn_feet_particles(jump_particle)
		else:
			spawn_feet_particles(double_jump_particle)
		
		# If is double jump
		if not is_on_floor():
			can_jump = false

func spawn_feet_particles(particleScene: PackedScene):
	var particle = particleScene.instantiate()
	particle.global_position = feet.global_position
	get_tree().get_current_scene().add_child(particle)

func just_landed():
	return is_on_floor() and landing
	
func jump_condition():
	return Input.is_action_just_pressed("jump") and (is_on_floor() || velocity.y < 80 || jump_count < 2)
