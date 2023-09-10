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


func trigger_thrust(activate: bool) -> void:
	if activate:
		target_thrust = Vector3.FORWARD * thrust_power + Vector3.UP * lift
	else:
		target_thrust = Vector3.ZERO


func trigger_direction(dir: Vector2) -> void:
	target_torque = -dir.x * turn_to_torque
	target_pitch = -dir.y * move_to_pitch


func _physics_process(delta: float) -> void:
	var torque: Vector3 = transform.basis * Vector3(target_pitch, 0.0, target_torque)
	var force: Vector3 = transform.basis * target_thrust
	apply_torque(torque)
	apply_central_force(force)


func _on_dir_changed(dir: Vector2) -> void:
	trigger_direction(dir)


func _on_main_action(pressed: bool) -> void:
	trigger_thrust(pressed)
