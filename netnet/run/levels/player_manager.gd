class_name PlayerManager
extends Node2D

const SPAWN_RANDOM := 100.0
const SPAWN_HEIGHT := 200.0

@onready var player_pool: Node2D = $PlayerPool

func _ready():
	# We only need to spawn players on the server.
	if not multiplayer.is_server():
		return

	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(del_player)

	# Spawn already connected players
	for id in multiplayer.get_peers():
		add_player(id)

	# Spawn the local player unless this is a dedicated server export.
	if not OS.has_feature("dedicated_server"):
		add_player(1)


func _exit_tree():
	if not multiplayer.is_server():
		return
	multiplayer.peer_connected.disconnect(add_player)
	multiplayer.peer_disconnected.disconnect(del_player)


func add_player(id: int):
	var character = preload("res://component/entity/jumper/jumper.tscn").instantiate()
	# Set player id.
	character.player = id
	# Randomize character position.
	character.position = Vector2(randf() * SPAWN_RANDOM, SPAWN_HEIGHT)
	character.name = str(id)
	player_pool.add_child(character, true)


func del_player(id: int):
	if not player_pool.has_node(str(id)):
		return
	player_pool.get_node(str(id)).queue_free()
