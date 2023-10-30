extends VSplitContainer


func resume() -> void:
	hide()
	get_tree().set_pause(false)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_pause"):
		if get_tree().is_paused():
			resume()
		else:
			get_tree().set_pause(true)
			show()


func _on_resume_button_pressed():
	resume()


func _on_title_button_pressed():
	get_tree().reload_current_scene()
	resume()


func _on_quit_button_pressed():
	get_tree().quit()


func _on_visibility_changed():
	%ResumeButton.grab_focus()
