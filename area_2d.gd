extends Area2D

@onready var sprite: Sprite2D = $Sprite2D

@export var sprite_free: Texture2D
@export var sprite_occupied: Texture2D

func _ready():
	collision_layer = 1 << 1       # camada 2 para a cadeira
	collision_mask = 1 << 0        # detecta player na camada 1

	# Conectando sinais corretamente no Godot 4
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

func show_occupied_sprite():
	sprite.texture = sprite_occupied

func show_default_sprite():
	sprite.texture = sprite_free
