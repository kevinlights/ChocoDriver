class_name LocalInput
extends Node
# Sends commands from a local device


signal dir_changed(new_dir: Vector2)
signal main_action(pressed: bool)
signal stop_action(pressed: bool)
signal get_in_action(commander: LocalInput)
signal analog_action(side: int, value: float)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("main"):
		main_action.emit(event.is_pressed())
	if event.is_action("stop"):
		stop_action.emit(event.is_pressed())
	elif event.is_action_pressed("get_in"):
		get_in_action.emit(self)
	elif event.is_action("move_left") or event.is_action("move_right") or event.is_action("move_back") or event.is_action("move_forward"):
		var dir: Vector2 = Input.get_vector("move_left", "move_right", "move_back", "move_forward")
		dir_changed.emit(dir)
	elif event.is_action("analog_main"):
		analog_action.emit(1, event.get_action_strength("analog_main"))
	elif event.is_action("analog_secondary"):
		analog_action.emit(-1, event.get_action_strength("analog_secondary"))


func _on_title_screen_start_game() -> void:
	_enable()


func _on_victory_menu_visibility_changed() -> void:
	queue_free()


func _enable() -> void:
	set_process_mode(Node.PROCESS_MODE_PAUSABLE)
