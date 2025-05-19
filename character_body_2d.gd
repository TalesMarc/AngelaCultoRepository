extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(_delta: float) -> void:
	# Pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Direções com nomes personalizados
	var horizontal_direction := Input.get_axis("esquerda", "direita")
	var vertical_direction := Input.get_axis("frente", "tras")  # Corrigido: frente = cima (W), tras = baixo (S)

	# Movimento horizontal
	if horizontal_direction != 0:
		velocity.x = horizontal_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Movimento vertical
	if vertical_direction != 0:
		velocity.y = vertical_direction * SPEED
	elif not Input.is_action_pressed("ui_accept"):  # Evita sobrescrever o pulo enquanto estiver no ar
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
