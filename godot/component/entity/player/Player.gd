extends CharacterBody2D


const SPEED = 300.0
const SLIDE = 50.0
const FORCE = 800.0



func _physics_process(delta):
	prepare_to_move()

	var collided = move_and_slide()

	if collided:
		try_to_shoot()


func prepare_to_move():
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SLIDE)

	if Input.is_action_pressed("ui_down"):
		velocity.y = SPEED
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SLIDE)


func try_to_shoot():
	var collision = get_last_slide_collision()
	var target = collision.get_collider()
	var normal = collision.get_normal()

	if target is PhysicsBody2D:
		shoot(target, -normal)


func shoot(target: PhysicsBody2D, dir: Vector2) -> void:
	target.apply_force(dir * FORCE)
