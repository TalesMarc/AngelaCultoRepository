extends Control

@onready var pause_menu = $PauseMenu
@onready var fade_rect = $FadeRect

@onready var hover_sound_player = $HoverSoundPlayer
@onready var click_sound_player = $ClickSoundPlayer

func _ready():
	if fade_rect:
		var c = fade_rect.modulate
		c.a = 0.0
		fade_rect.modulate = c
		fade_rect.visible = true
	else:
		print("ERRO: fade_rect não encontrado!")

	# Busca recursiva e conecta todos os botões
	var botoes = get_all_buttons(self)
	for botao in botoes:
		botao.connect("mouse_entered", Callable(self, "_on_button_mouse_entered"))
		botao.connect("pressed", Callable(self, "_on_button_pressed"))

func get_all_buttons(node):
	var buttons = []
	for child in node.get_children():
		if child is Button or child is TextureButton:
			buttons.append(child)
		buttons += get_all_buttons(child)
	return buttons


func toggle_pause():
	get_tree().paused = not get_tree().paused
	pause_menu.visible = get_tree().paused

func _on_resume_button_pressed():
	toggle_pause()

func _on_main_menu_button_pressed():
	get_tree().paused = false
	if ResourceLoader.exists("res://inicio.tscn"):
		get_tree().change_scene_to_file("res://inicio.tscn")
	else:
		print("ERRO: Cena 'inicio.tscn' não encontrada!")

func _on_quit_button_pressed():
	get_tree().quit()

func _process(_delta: float) -> void:
	pass

func _on_pressed() -> void:
	get_tree().quit()

func voltar_on_pressed() -> void:
	if ResourceLoader.exists("res://inicio.tscn"):
		get_tree().change_scene_to_file("res://inicio.tscn")
	else:
		print("ERRO: Cena 'inicio.tscn' não encontrada!")

func _on_texture_button_2_pressed() -> void:
	if click_sound_player.playing:
		click_sound_player.stop()
	click_sound_player.play()

	if ResourceLoader.exists("res://configuracoes.tscn"):
		get_tree().change_scene_to_file("res://configuracoes.tscn")
	else:
		print("ERRO: Cena 'configuracoes.tscn' não encontrada!")

func _on_texture_button_3_pressed() -> void:
	await fade_out()
	if ResourceLoader.exists("res://node_2d.tscn"):
		get_tree().change_scene_to_file("res://node_2d.tscn")
	else:
		print("ERRO: Cena 'node_2d.tscn' não encontrada!")

func fade_out() -> void:
	if fade_rect:
		var tween = create_tween()
		tween.tween_property(fade_rect, "modulate:a", 1.0, 1.0)
		await tween.finished
	else:
		print("ERRO: fade_rect não encontrado para fazer fade out!")

func _on_sair_button_pressed() -> void:
	if click_sound_player.playing:
		click_sound_player.stop()
	click_sound_player.play()
	
	get_tree().quit()

# Sons:

func _on_button_mouse_entered():
	if hover_sound_player.playing:
		hover_sound_player.stop()
	hover_sound_player.play()

func _on_button_pressed():
	if click_sound_player.playing:
		click_sound_player.stop()
	click_sound_player.play()
