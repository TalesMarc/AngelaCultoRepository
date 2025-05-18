extends CharacterBody2D

@export var speed: float = 200.0
const GRAVITY = 1000.0
const JUMP_VELOCITY = -900.0
const FALL_LIMIT = 1000.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var respawn_position: Vector2 = Vector2(100, 100)

# Controle de interação com objetos (ex: cadeira)
var is_interacting: bool = false
var current_interactable: Node = null

func _physics_process(delta: float) -> void:
	# Aplica gravidade se não estiver no chão
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Pular se estiver no chão e tecla pressionada (se não estiver interagindo)
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_interacting:
		velocity.y = JUMP_VELOCITY

	# Movimento horizontal (apenas se não estiver interagindo)
	var input_direction := 0
	if not is_interacting:
		if Input.is_action_pressed("move_left"):
			input_direction -= 1
		if Input.is_action_pressed("move_right"):
			input_direction += 1

		# Verifica se está correndo
		var current_speed = speed
		if Input.is_action_pressed("correr"):
			current_speed *= 1.8  # ou use *= 2.0 para dobrar a velocidade

		velocity.x = input_direction * current_speed
	else:
		velocity.x = 0  # Sem movimento horizontal ao interagir

	# Move o player e lida com colisões
	move_and_slide()

	# Animações conforme direção
	if input_direction > 0:
		sprite.play("Direita")
	elif input_direction < 0:
		sprite.play("Esquerda")
	else:
		sprite.play("Parado")

	# Se cair abaixo do limite, respawna
	if position.y > FALL_LIMIT:
		position = respawn_position
		velocity = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if is_interacting:
			_stop_interaction()
		elif current_interactable:
			_start_interaction()

func _start_interaction() -> void:
	# Começa a interação (ex: sentar na cadeira)
	is_interacting = true
	current_interactable.show_occupied_sprite()
	visible = false  # Faz o player sumir (sentado)
	print("Player sentou na cadeira")

func _stop_interaction() -> void:
	# Termina a interação (ex: levantar da cadeira)
	is_interacting = false
	current_interactable.show_default_sprite()
	visible = true
	print("Player levantou da cadeira")
