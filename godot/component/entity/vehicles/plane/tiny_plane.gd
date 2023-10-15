class_name TinyPlane
extends VehicleBody3D

@export var thrust_power: float = 10000.0
@export var turn_to_torque: float = 2000.0
@export var move_to_pitch: float = 4000.0
@export var wing_resistance: float = 10.0
@export var lift: float = 500.0

var target_torque: float = 0.0
var target_pitch: float = 0.0
var target_rotation := Vector3.ZERO
var target_thrust := Vector3.ZERO

var _current_commander: LocalInput = null


func trigger_thrust(activate: bool) -> void:
	if activate:
		target_thrust = Vector3.FORWARD * thrust_power
	else:
		target_thrust = Vector3.ZERO


func trigger_direction(dir: Vector2) -> void:
	target_torque = -dir.x * turn_to_torque
	target_pitch = -dir.y * move_to_pitch


## Make the vehicle responds to driver commands
func drive_with(commander: LocalInput) -> void:
	commander.dir_changed.connect(_on_dir_changed)
	commander.main_action.connect(_on_main_action)
	_current_commander = commander


func get_out() -> void:
	_current_commander.dir_changed.disconnect(_on_dir_changed)
	_current_commander.main_action.disconnect(_on_main_action)
	_current_commander = null


func get_free_seat() -> Node3D:
	return $DrivingSeat


func _physics_process(delta: float) -> void:
	_apply_plane_rotation()
	_apply_plane_thrust()
	_apply_wing_resistance()
	_apply_lift()


func _apply_plane_rotation() -> void:
	var torque: Vector3 = transform.basis * Vector3(target_pitch, 0.0, target_torque)
	apply_torque(torque)


func _apply_plane_thrust() -> void:
	var force: Vector3 = transform.basis * target_thrust
	apply_central_force(force)


func _apply_wing_resistance() -> void:
	var vertical_speed = linear_velocity.dot(transform.basis * Vector3.UP)
	var local_wing_force = Vector3.UP * -wing_resistance * vertical_speed
	var wing_force = transform.basis * local_wing_force
	if _current_commander != null:
		print("= = =")
		print("Vertical speed : ", vertical_speed)
		print("Wing force local :", local_wing_force)
		print("Wing force : ", wing_force)
	apply_central_force(wing_force)


func _apply_lift() -> void:
	var forward_speed = linear_velocity.dot(transform.basis * Vector3.FORWARD)
	if forward_speed < 0.0 :
		forward_speed = 0.0
	var local_lift_force = Vector3.UP * lift * forward_speed
	var lift_force = transform.basis * local_lift_force
	if _current_commander != null:
		print("- - -")
		print("Forward speed : ", forward_speed)
		print("Lift force local :", local_lift_force)
		print("Lift force : ", lift_force)
	apply_central_force(lift_force)


func _on_dir_changed(dir: Vector2) -> void:
	trigger_direction(dir)


func _on_main_action(pressed: bool) -> void:
	trigger_thrust(pressed)
