class_name LocalInput
extends Node
# Sends commands from a local device

signal dir_changed(new_dir: Vector2)
signal main_action

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		main_action.emit()
	elif event is InputEventJoypadMotion:
		var dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
		dir_changed.emit(dir)
