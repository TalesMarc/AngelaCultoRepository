extends CharacterBody2D

var speed := 100.0  # variável que controla a velocidade do personagem
const JUMP_VELOCITY = -400.0

func _physics_process(_delta):
	# Se speed for zero, bloqueia o movimento
	if speed == 0:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	# Pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var horizontal_direction := Input.get_axis("esquerda", "direita")
	var vertical_direction := Input.get_axis("frente", "tras")

	if horizontal_direction != 0:
		velocity.x = horizontal_direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if vertical_direction != 0:
		velocity.y = vertical_direction * speed
	elif not Input.is_action_pressed("ui_accept"):
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
