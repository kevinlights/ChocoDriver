class_name CrashEffect
extends Node3D


var _noise_finished: bool = false
var _splash_finished: bool = false


func _on_noise_finished() -> void:
	_noise_finished = true
	_die_if_completed()


func _on_splash_finished() -> void:
	_splash_finished = true
	_die_if_completed()


func _die_if_completed() -> void:
	if _noise_finished and _splash_finished:
		queue_free()
