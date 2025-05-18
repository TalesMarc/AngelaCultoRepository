extends Area2D

@onready var sprite_free: Sprite2D = $SpriteVazia
@onready var sprite_occupied: Sprite2D = $SpriteOcupada

func _ready() -> void:
	# Define camadas de colisão
	collision_layer = 1 << 1       # Cadeira está na camada 2
	collision_mask = 1 << 0        # Detecta o player (camada 1)

	# Exibe apenas a cadeira vazia no início
	sprite_free.visible = true
	sprite_occupied.visible = false

	# Conecta os sinais do corpo entrando/saindo da área
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		body.current_interactable = self
		print("Player entrou na área da cadeira")

func _on_body_exited(body: Node) -> void:
	if body.name == "Player" and body.current_interactable == self:
		body.current_interactable = null
		print("Player saiu da área da cadeira")

func show_occupied_sprite() -> void:
	sprite_free.visible = false
	sprite_occupied.visible = true
	print("Cadeira ocupada")

func show_default_sprite() -> void:
	sprite_free.visible = true
	sprite_occupied.visible = false
	print("Cadeira livre")
