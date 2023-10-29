class_name Jeep
extends SeatedVehicle

@export var max_engine_force: float = 500
@export var max_brake_force: float = 50
@export var max_steering: float = PI / 6.0 # degrees


func steer(ratio: float) -> void:
	set_steering(ratio * max_steering)


func hand_brake(enabled: bool) -> void:
	if enabled:
		set_brake(max_brake_force)
	else:
		set_brake(0.0)


func get_free_seat() -> Node3D:
	return %RearSeat


func drive_with(commander: LocalInput) -> void:
	hand_brake(false)
	super.drive_with(commander)


func get_out() -> void:
	hand_brake(true)
	super.get_out()


func _on_dir_changed(dir: Vector2) -> void:
	steer(-dir.x)


func _on_main_action(pressed: bool) -> void:
	if pressed:
		set_engine_force(max_engine_force)
	else:
		set_engine_force(0.0)


func _on_stop_action(pressed: bool) -> void:
	hand_brake(pressed)


func _on_analog_action(side: int, value: float) -> void:
	set_engine_force(side * value * max_engine_force)
