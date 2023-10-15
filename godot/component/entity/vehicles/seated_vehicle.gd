class_name SeatedVehicle
extends VehicleBody3D

var _current_commander: LocalInput = null


## Make the vehicle responds to driver commands
func drive_with(commander: LocalInput) -> void:
	commander.dir_changed.connect(_on_dir_changed)
	commander.main_action.connect(_on_main_action)
	_current_commander = commander


func get_out() -> void:
	_current_commander.dir_changed.disconnect(_on_dir_changed)
	_current_commander.main_action.disconnect(_on_main_action)
	_current_commander = null


## Need to be overriden to return an available seat
func get_free_seat() -> Node3D:
	return null


## Need to be overriden to react to direction changed
func _on_dir_changed(dir: Vector2) -> void:
	pass


## Need to be overriden to react to main action
func _on_main_action(pressed: bool) -> void:
	pass
