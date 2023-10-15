class_name CameraTracker
extends Camera3D
## Track object in subject view


@export var max_distance: float = 10
@export var camera_height: float = 1

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
	_adjust_max_distance_from(target)
	_adjust_min_distance_from(target)


func _adjust_max_distance_from(target: Vector3) -> void:
	var current_distance: float = position.distance_to(target)
	if current_distance > max_distance:
		var diff: float = current_distance - max_distance
		position += transform.basis * Vector3.FORWARD * diff


func _adjust_min_distance_from(target: Vector3) -> void:
	var target_height: float = target.y + camera_height
	if position.y < target_height:
		position.y = target_height


func _on_focus_required(node: Node3D) -> void:
	track(node)
