class_name CrashEffect
extends Node3D


func _on_noise_finished():
	queue_free()
