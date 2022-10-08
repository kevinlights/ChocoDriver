extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta):


	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_pressed("ui_down"):
		velocity.y = SPEED
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
