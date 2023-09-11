class_name CameraTracker
extends Camera3D
## Track object in subject view


@export var max_distance: float = 10

var _tracked_node: Node3D


func track(node: Node3D) -> void:
	_tracked_node = node


func _process(_delta: float) -> void:
	if _tracked_node == null:
		return

	look_at(_tracked_node.get_global_position())

	_adjust_distance()


func _adjust_distance() -> void:
	var target: Vector3 = _tracked_node.get_global_position()
	var current_distance: float = position.distance_to(target)
	push_error()
	if current_distance > max_distance:
		var diff: float = current_distance - max_distance
		set_position(position + transform.basis * Vector3.FORWARD * diff)


func _on_focus_required(node: Node3D) -> void:
	track(node)
