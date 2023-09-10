class_name LocalInput
extends Node
# Sends commands from a local device

signal dir_changed(new_dir: Vector2)
signal main_action(pressed: bool)
signal get_in_action(commander: LocalInput)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("main"):
		main_action.emit(event.is_pressed())
	elif event.is_action_pressed("get_in"):
		get_in_action.emit(self)
	elif event.is_action("move_left") or event.is_action("move_right") or event.is_action("move_back") or event.is_action("move_forward"):
		var dir: Vector2 = Input.get_vector("move_left", "move_right", "move_back", "move_forward")
		dir_changed.emit(dir)
