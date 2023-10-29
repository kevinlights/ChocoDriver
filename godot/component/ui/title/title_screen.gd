extends VSplitContainer


signal start_game


func _ready() -> void:
	%StartButton.grab_focus()


func _on_start_button_pressed():
	start_game.emit()
	queue_free()


func _on_quit_button_pressed():
	get_tree().quit()
