extends Camera2D

@export var zoom_ao_aproximar := Vector2(4, 4)
@export var tempo_da_transicao := 0.4

var zoom_original: Vector2
var esta_aproximado := false
var tween_ativo: Tween
var jogador: Node2D

# Guardar configs originais do deadzone (drag margin)
var drag_top_original := 0.0
var drag_bottom_original := 0.0
var drag_left_original := 0.0
var drag_right_original := 0.0

func _ready():
	make_current()
	jogador = get_node("/root/Gameplay1/Personagens/Persona1")
	zoom_original = zoom

	# salvar configurações originais do deadzone
	drag_top_original = drag_top_margin
	drag_bottom_original = drag_bottom_margin
	drag_left_original = drag_left_margin
	drag_right_original = drag_right_margin

func _input(event):
	if event.is_action_pressed("menu"):
		if tween_ativo and tween_ativo.is_running():
			return  # bloqueia se já tem tween ativo

		if esta_aproximado:
			restaurar_zoom_e_deadzone()
		else:
			aplicar_zoom_e_diminuir_deadzone()

func aplicar_zoom_e_diminuir_deadzone():
	esta_aproximado = true
	cancelar_tween_anterior()

	# Garante que as margens começam no original antes do tween
	drag_top_margin = drag_top_original
	drag_bottom_margin = drag_bottom_original
	drag_left_margin = drag_left_original
	drag_right_margin = drag_right_original

	tween_ativo = get_tree().create_tween()
	
	# Faz os tweens em paralelo (simultâneos)
	tween_ativo.parallel().tween_property(self, "zoom", zoom_ao_aproximar, tempo_da_transicao).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_ativo.parallel().tween_property(self, "drag_top_margin", 0.0, tempo_da_transicao).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_ativo.parallel().tween_property(self, "drag_bottom_margin", 0.0, tempo_da_transicao).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_ativo.parallel().tween_property(self, "drag_left_margin", 0.0, tempo_da_transicao).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_ativo.parallel().tween_property(self, "drag_right_margin", 0.0, tempo_da_transicao).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func restaurar_zoom_e_deadzone():
	esta_aproximado = false
	cancelar_tween_anterior()

	tween_ativo = get_tree().create_tween()
	
	# Faz os tweens em paralelo (simultâneos)
	tween_ativo.parallel().tween_property(self, "zoom", zoom_original, tempo_da_transicao).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_ativo.parallel().tween_property(self, "drag_top_margin", drag_top_original, tempo_da_transicao).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_ativo.parallel().tween_property(self, "drag_bottom_margin", drag_bottom_original, tempo_da_transicao).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_ativo.parallel().tween_property(self, "drag_left_margin", drag_left_original, tempo_da_transicao).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween_ativo.parallel().tween_property(self, "drag_right_margin", drag_right_original, tempo_da_transicao).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func cancelar_tween_anterior():
	if tween_ativo and tween_ativo.is_running():
		tween_ativo.kill()
	tween_ativo = null
