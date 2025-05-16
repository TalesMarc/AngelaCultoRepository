extends CharacterBody2D

# Variáveis
@export var speed: float = 200.0
const JUMP_VELOCITY = -900.0
const GRAVITY = 1000.0
const FALL_LIMIT = 1000.0
const SPEED_X = 300.0  # Velocidade horizontal separada do AnimatedSprite2D

var respawn_position = Vector2(100, 100)

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Aplica gravidade
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Pulo
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movimento horizontal
	var input_direction := 0
	if Input.is_action_pressed("move_left"):
		input_direction -= 1
	if Input.is_action_pressed("move_right"):
		input_direction += 1
	velocity.x = input_direction * SPEED_X

	# Movimento real
	move_and_slide()

	# Animações
	if input_direction > 0:
		sprite.play("Direita")
	elif input_direction < 0:
		sprite.play("Esquerda")
	else:
		sprite.play("Parado")

	# Voltar ao respawn se cair da tela
	if position.y > FALL_LIMIT:
		position = respawn_position
		velocity = Vector2.ZERO
