class_name MusicPlayer
extends AudioStreamPlayer


func resume() -> void:
	if stream_paused:
		stream_paused = false
	else:
		play()


func pause() -> void:
	stream_paused = true


func _on_driver_got_in():
	print("play")
	resume()


func _on_driver_got_out():
	print("stop")
	pause()
