extends AudioStreamPlayer3D

const crash_sounds: Array[AudioStream] = [
	preload("res://effect/crash/crash0.wav"),
	preload("res://effect/crash/crash1.wav"),
	preload("res://effect/crash/crash2.wav"),
	preload("res://effect/crash/crash3.wav"),
]


func _ready() -> void:
	stream = _pick_random_sound()
	play()


func _pick_random_sound() -> AudioStream:
	var rand_index: int = randi_range(0, crash_sounds.size() - 1)
	return crash_sounds[rand_index]
