class_name Jumper
extends RigidBody2D

const SPEED = 5.0
const JUMP_IMPULSE = 942.5
const MOVE_FORCE = 1142

# Set by the authority, synchronized on spawn.
@export var player := 1 :
	set(id):
		player = id
		# Give authority over the player input to the appropriate peer.
		$JumperInput.set_multiplayer_authority(id)

# Player synchronized input
@onready var input: JumperInput = $JumperInput


func _ready():
	pass


func _physics_process(delta):

	# Handle Jump.
	if input.jumping:
		apply_impulse(Vector2.UP * JUMP_IMPULSE)

	# Reset jump state.
	input.jumping = false

	# Handle movement.
	var direction = input.direction
	if direction:
		apply_force(direction * MOVE_FORCE)
