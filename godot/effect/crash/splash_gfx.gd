extends GPUParticles3D


signal finished


func _ready() -> void:
	set_emitting(true)
	var emission_timer: SceneTreeTimer = get_tree().create_timer(get_lifetime(), false, true)
	emission_timer.timeout.connect(_on_emission_ended)


func _on_emission_ended() -> void:
	finished.emit()
