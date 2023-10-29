extends VSplitContainer



func _ready() -> void:
	%StartButton.grab_focus()


func _on_start_button_pressed():
	print("start")


func _on_quit_button_pressed():
	get_tree().quit()
