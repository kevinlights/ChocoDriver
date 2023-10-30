extends VSplitContainer


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel") and not get_tree().is_paused():
		get_tree().set_pause(true)
		show()


func _on_resume_button_pressed():
	hide()
	get_tree().set_pause(false)


func _on_title_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()


func _on_visibility_changed():
	%ResumeButton.grab_focus()
