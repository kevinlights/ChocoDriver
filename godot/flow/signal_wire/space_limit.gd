extends Node3D


@export var message: String

signal space_reached(message: String)


func _on_body_shape_entered(_body_rid, _body, _body_shape_index, _local_shape_index) -> void:
	space_reached.emit(message)
