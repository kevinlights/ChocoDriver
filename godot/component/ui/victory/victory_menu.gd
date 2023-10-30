extends VSplitContainer


func _ready() -> void:
	set_process_input(false) # Otherwise pause is disabled


func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_pause"):
		# Prevent title screen to be paused
		get_viewport().set_input_as_handled()


func _on_title_button_pressed():
	get_tree().reload_current_scene()


func _on_quit_button_pressed():
	get_tree().quit()


func _on_visibility_changed():
	set_process_input(true)
	%TitleButton.grab_focus()


func _on_bottom_limit_area_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index) -> void:
	show()
