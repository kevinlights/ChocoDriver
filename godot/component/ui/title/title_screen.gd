extends VSplitContainer


signal start_game


func _ready() -> void:
	%StartButton.grab_focus()


func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_pause"):
		# Prevent title screen to be paused
		get_viewport().set_input_as_handled()


func _on_start_button_pressed():
	start_game.emit()
	queue_free()


func _on_quit_button_pressed():
	get_tree().quit()
