extends Camera2D

@export var zoom_menu := Vector2(0.5, 0.5)  # Zoom ao abrir o menu
@export var transition_time := 0.5  # Tempo da transição

var original_zoom: Vector2
var original_position: Vector2
var is_centered := false
var player: Node2D

func _ready():
	# Localiza automaticamente o personagem, mesmo com a hierarquia
	player = get_node("../../")  # Sobe 2 níveis para pegar Persona1
	original_zoom = zoom
	original_position = global_position

func _process(_delta):
	if Input.is_action_just_pressed("menu"):
		if is_centered:
			restaurar_camera()
		else:
			centralizar_no_jogador()

func centralizar_no_jogador():
	if not player:
		return
	is_centered = true
	original_zoom = zoom
	original_position = global_position

	var tween = get_tree().create_tween()
	tween.tween_property(self, "zoom", zoom_menu, transition_time).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "global_position", player.global_position, transition_time).set_trans(Tween.TRANS_SINE)

func restaurar_camera():
	is_centered = false
	var tween = get_tree().create_tween()
	tween.tween_property(self, "zoom", original_zoom, transition_time).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "global_position", original_position, transition_time).set_trans(Tween.TRANS_SINE)
