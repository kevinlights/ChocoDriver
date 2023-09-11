extends VehicleBody3D

@onready var max_engine_force: float = 500
@onready var max_steering: float = PI / 6.0 # degrees

var _current_commander: LocalInput = null


func steer(ratio: float) -> void:
	set_steering(ratio * max_steering)


## Make the vehicle responds to driver commands
func drive_with(commander: LocalInput) -> void:
	commander.dir_changed.connect(_on_dir_changed)
	commander.main_action.connect(_on_main_action)
	_current_commander = commander


func get_out() -> void:
	_current_commander.dir_changed.disconnect(_on_dir_changed)
	_current_commander.main_action.disconnect(_on_main_action)


func _on_dir_changed(dir: Vector2) -> void:
	steer(-dir.x)


func _on_main_action(pressed: bool) -> void:
	if pressed:
		set_engine_force(max_engine_force)
	else:
		set_engine_force(0.0)
