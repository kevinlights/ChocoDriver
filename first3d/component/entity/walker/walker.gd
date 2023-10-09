class_name Walker
extends CharacterBody3D


signal focus_required(me: Node3D)

## How fast the player moves in meters per second.
@export var speed = 14
## Convert an axis from [-1, -1] to rad
@export var turn_to_rad: float = 0.020
## The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
## Vertical impulse applied to the character upon jumping in meters per second.
@export var jump_impulse = 20

@export_group("Seat", "seat_")
@export var seat_min_dist: float = 0.0005
@export var seat_access_speed: float = 2.0
@export var seat_rotation_duration: float = 1.0

var target_velocity := Vector3.ZERO
var target_rotation: float = 0.0

var _vehicle: Node3D = null
var _seat: Node3D = null

@onready var _vehicle_range: RayCast3D = $VehicleRange


func _ready() -> void:
	focus_required.emit(self)


func trigger_jump() -> void:
	if is_on_floor():
		target_velocity.y = jump_impulse


func trigger_direction(dir: Vector2) -> void:
	target_rotation = -dir.x * turn_to_rad
	var ground_velocity: Vector2 = Vector2.UP.rotated(-global_rotation.y) * dir.y * speed
	target_velocity.x = ground_velocity.x
	target_velocity.z = ground_velocity.y


## Return true if inside a vehicle
func is_onboard() -> bool:
	return _vehicle != null


func _physics_process(delta: float) -> void:
	if is_onboard():
		_get_on_driver_seat()
	else:
		_move_with_feet(delta)


func _move_with_feet(delta: float):
	rotate_y(target_rotation)

	# Gravity
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	velocity = target_velocity
	move_and_slide()


func _get_on_driver_seat() -> void:
	if _seat == null :
		return

	if position.distance_squared_to(_seat.position) < seat_min_dist:
		print("Seat reachead at ", _seat.position)
		_seat = null
		return

	var rotation_tween: Tween = create_tween()
	rotation_tween.tween_property(self, "quaternion", _seat.quaternion, seat_rotation_duration)

	var local_velocity = (_seat.position - position).normalized() * seat_access_speed
	velocity = get_parent().get_transform().basis * local_velocity
	print("- I'm at ", position, ", going to ", _seat.position, " with speed ", velocity)
	move_and_slide()


func _on_dir_changed(dir: Vector2) -> void:
	trigger_direction(dir)


func _on_main_action(pressed: bool) -> void:
	if pressed:
		trigger_jump()


func _on_get_in_action(commander: LocalInput) -> void:
	if is_onboard():
		_get_out_vehicle()
	else:
		_get_in_vehicle(commander)


## Seek the first vehicle in front of the player
## and get in to it
## and take the wheel !
func _get_in_vehicle(commander: LocalInput) -> void:
	var closest_vehicle: Node3D = _get_closest_vehicle()

	if closest_vehicle == null:
		return # No vehicle to get inside

	_vehicle = closest_vehicle
	reparent(_vehicle)
	add_collision_exception_with(_vehicle)
	_vehicle.drive_with(commander)
	_seat = _find_seat_on(_vehicle)
	print("I'm at ", position, " and I want to seat on ", _seat.position)


## Get out of the current vehicle
func _get_out_vehicle() -> void:
	_vehicle.get_out()
	remove_collision_exception_with(_vehicle)
	reparent(_vehicle.get_parent())
	_vehicle = null
	_seat = null
	_get_head_up()


## Make the player stand up
func _get_head_up():
	set_rotation(Vector3(0.0, rotation.y, 0.0))


## Return closest vehicle within reach
## or null if there are none
func _get_closest_vehicle() -> Node3D:
	_vehicle_range.force_raycast_update()

	var object_within_range: Object = _vehicle_range.get_collider()

	if object_within_range is Node3D:
		var node_within_range: Node3D = object_within_range as Node3D

		if node_within_range.is_in_group("vehicle"):
			print("Get in ", node_within_range)
			return node_within_range

	print("No vehicle found")
	return null


## Have a seat on the driven vehicle if a seat
## is available
func _find_seat_on(vehicule: Node3D) -> Node3D:
	if vehicule.has_method("get_free_seat") :
		return vehicule.get_free_seat()

	return null
