class_name SeatedVehicle
extends VehicleBody3D

const CRASH_EFFECT: Resource = preload("res://effect/crash/crash.tscn")

var _current_commander: LocalInput = null


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


func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if body is Node3D:
		_crash_on(body as Node3D)


func _crash_on(body: Node3D) -> void:
	var crash_effect: CrashEffect = CRASH_EFFECT.instantiate()
	crash_effect.position = _get_contact_from(body)
	get_parent_node_3d().add_child(crash_effect)


func _get_contact_from(body: Node3D) -> Vector3:
	return body.get_position()


## Need to be overridden to return an available seat
func get_free_seat() -> Node3D:
	return null


## Need to be overridden to react to direction changed
func _on_dir_changed(dir: Vector2) -> void:
	pass


## Need to be overridden to react to main action
func _on_main_action(pressed: bool) -> void:
	pass
