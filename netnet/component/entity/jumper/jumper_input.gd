class_name JumperInput
extends MultiplayerSynchronizer


const STICK_DEADZONE: float = 0.5

# Set via RPC to simulate is_action_just_pressed.
@export var jumping: bool = false

# Synchronized property.
@export var direction := Vector2()


func _ready():
	# Only process for the local player
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())


@rpc("call_local")
func jump() -> void:
	jumping = true


func _process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.

	direction = _new_direction()
	if Input.is_action_just_pressed("jump"):
		jump.rpc()


func _new_direction() -> Vector2:
	var new_dir := Vector2(Input.get_joy_axis(0, JOY_AXIS_LEFT_X), 0.0)
	if absf(new_dir.x) < STICK_DEADZONE:
		new_dir.x = 0.0

	new_dir.x += Input.get_axis("move_left", "move_right")

	if new_dir == Vector2.ZERO:
		return Vector2.ZERO

	return new_dir.normalized()
