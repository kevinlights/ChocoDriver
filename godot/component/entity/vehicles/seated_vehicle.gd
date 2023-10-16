class_name SeatedVehicle
extends VehicleBody3D

const CRASH_EFFECT: Resource = preload("res://effect/crash/crash.tscn")
const MINIMAL_CRASH_SPEED: float = 1.0 # m2/s2

var _current_commander: LocalInput = null
var _has_collided: bool = false


func _init() -> void:
	body_shape_entered.connect(_on_body_shape_entered)


## Make the vehicle responds to driver commands
func drive_with(commander: LocalInput) -> void:
	commander.dir_changed.connect(_on_dir_changed)
	commander.main_action.connect(_on_main_action)
	_current_commander = commander


func get_out() -> void:
	_current_commander.dir_changed.disconnect(_on_dir_changed)
	_current_commander.main_action.disconnect(_on_main_action)
	_current_commander = null


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if state.get_contact_count() <= 0:
		return

	if _has_collided and linear_velocity.length_squared() > MINIMAL_CRASH_SPEED:
		_crash_on(state.get_contact_collider_position(0))
		_has_collided = false


func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if body is Walker:
		return

	_has_collided = true


func _crash_on(pos: Vector3) -> void:
	var crash_effect: CrashEffect = CRASH_EFFECT.instantiate()
	crash_effect.position = pos
	get_parent_node_3d().add_child(crash_effect)


## Need to be overridden to return an available seat
func get_free_seat() -> Node3D:
	return null


## Need to be overridden to react to direction changed
func _on_dir_changed(dir: Vector2) -> void:
	pass


## Need to be overridden to react to main action
func _on_main_action(pressed: bool) -> void:
	pass
