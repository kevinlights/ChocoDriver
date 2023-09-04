class_name TinyPlane
extends RigidBody3D

@export var thrust_power: float = 10000.0
@export var turn_to_torque: float = 2000.0
@export var move_to_pitch: float = 4000.0
@export var lift: float = 10000.0

var target_torque: float = 0.0
var target_pitch: float = 0.0
var target_rotation := Vector3.ZERO
var target_thrust := Vector3.ZERO


func trigger_thrust() -> void:
	target_thrust = Vector3.FORWARD * thrust_power + Vector3.UP * lift


func trigger_direction(dir: Vector2) -> void:
	print(dir)
	target_torque = -dir.x * turn_to_torque
	target_pitch = -dir.y * move_to_pitch


func _physics_process(delta: float) -> void:
	apply_torque(transform * Vector3(target_pitch, 0.0, target_torque))
	apply_central_force(transform * target_thrust)


func _on_dir_changed(dir: Vector2) -> void:
	trigger_direction(dir)


func _on_main_action() -> void:
	trigger_thrust()
