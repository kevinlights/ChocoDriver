class_name Walker
extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO


func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO

	var ground_velocity: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")

	# Ground Velocity
	target_velocity.x = ground_velocity.x * speed
	target_velocity.z = ground_velocity.y * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
