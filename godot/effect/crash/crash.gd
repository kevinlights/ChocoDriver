class_name CrashEffect
extends Node3D


func _init():
	print("Crash init")


func _ready():
	print("Crash ready")


func _on_noise_finished():
	print("Crash end")
	queue_free()
