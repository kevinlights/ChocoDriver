class_name LocalInput
extends Node
# Sends commands from a local device

signal dir_changed(new_dir: Vector2)
signal main_action(pressed: bool)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("jump"):
		main_action.emit(event.is_pressed())
	elif event is InputEventJoypadMotion:
		var dir: Vector2 = Input.get_vector("move_left", "move_right", "move_back", "move_forward")
		dir_changed.emit(dir)
