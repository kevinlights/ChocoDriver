class_name Walker
extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# Convert an axis from [-1, -1] to rad
@export var turn_to_rad: float = 0.020
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
# Vertical impulse applied to the character upon jumping in meters per second.
@export var jump_impulse = 20

var target_velocity := Vector3.ZERO
var target_rotation: float = 0.0


func trigger_jump() -> void:
	if is_on_floor():
		target_velocity.y = jump_impulse


func trigger_direction(dir: Vector2) -> void:
	target_rotation = -dir.x * turn_to_rad
	var ground_velocity: Vector2 = Vector2.UP.rotated(-global_rotation.y) * dir.y * speed
	target_velocity.x = ground_velocity.x
	target_velocity.z = ground_velocity.y


func _physics_process(delta: float) -> void:
	rotate_y(target_rotation)

	# Gravity
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()


func _on_dir_changed(dir: Vector2) -> void:
	trigger_direction(dir)


func _on_main_action(pressed: bool) -> void:
	if pressed:
		trigger_jump()
