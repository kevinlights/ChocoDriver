extends AudioStreamPlayer3D

const crash_sound: Resource = preload("res://effect/crash/crash.wav")


func _ready() -> void:
	stream = crash_sound
	play()
