extends CharacterBody2D

# Configurações (ajuste no Inspector)
@export var speed: float = 280.0
@export var acceleration: float = 14.0
@export var gravity: float = 1400.0
@export var min_distance: float = 60.0

# Componentes
var target: CharacterBody2D = null
var detection_area: Area2D

func _ready():
	# Cria a área de detecção automaticamente
	_create_detection_area()
	
	# Busca inicial pelo player
	target = _find_player()

func _physics_process(delta):
	_apply_gravity(delta)
	_update_movement(delta)
	move_and_slide()
	
	# Debug visual
	queue_redraw()

func _create_detection_area():
	detection_area = Area2D.new()
	detection_area.name = "DetectionArea"
	
	var collision = CollisionShape2D.new()
	collision.shape = CircleShape2D.new()
	collision.shape.radius = 500  # Alcance de detecção
	
	detection_area.add_child(collision)
	add_child(detection_area)
	
	# Conecta os sinais CORRETAMENTE
	detection_area.body_entered.connect(_on_body_detected)
	detection_area.body_exited.connect(_on_body_lost)

func _find_player():
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		return players[0] as CharacterBody2D
	return null

func _apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

func _update_movement(delta):
	if not target:
		velocity.x = move_toward(velocity.x, 0, acceleration * delta)
		return
	
	var direction = (target.global_position - global_position).normalized()
	var distance = global_position.distance_to(target.global_position)
	
	if distance > min_distance:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration * 2 * delta)

func _on_body_detected(body: Node):
	if body.name == "player" and body is CharacterBody2D:
		target = body
		print("Player detectado!")

func _on_body_lost(body: Node):
	if body == target:
		target = null
		print("Player saiu do alcance")

func _draw():
	if target:
		var dir = (target.global_position - global_position).normalized()
		draw_line(Vector2.ZERO, dir * 70, Color(1, 0.2, 0.2), 3)
