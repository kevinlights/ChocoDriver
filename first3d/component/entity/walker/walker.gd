class_name Walker
extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
# Vertical impulse applied to the character upon jumping in meters per second.
@export var jump_impulse = 20

var target_velocity = Vector3.ZERO


func trigger_jump() -> void:
	if is_on_floor():
		target_velocity.y = jump_impulse


func trigger_direction(dir: Vector2) -> void:
	target_velocity.x = dir.x * speed
	target_velocity.z = dir.y * speed


func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()


func _on_dir_changed(dir: Vector2) -> void:
	trigger_direction(dir)


func _on_main_action() -> void:
	trigger_jump()
