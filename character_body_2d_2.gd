extends CharacterBody2D

const SPEED = 3000.0
const JUMP_VELOCITY = -900.0
var respawn_position = Vector2(100, 100)  # Posição onde o jogador vai reaparecer

func _physics_process(delta: float) -> void:
	# Aplica gravidade
	if not is_on_floor():
		velocity.y += 1000 * delta  # Ajuste para gravidade

	# Pular com espaço
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movimento com A e D
	var direction := 0
	if Input.is_action_pressed("move_left"):
		direction -= 1
	if Input.is_action_pressed("move_right"):
		direction += 1
	velocity.x = direction * SPEED

	# Faz o jogador voltar se cair da tela
	if position.y > 1000:
		position = respawn_position
		velocity = Vector2.ZERO

	move_and_slide()
