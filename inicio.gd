extends Control

@onready var pause_menu = $PauseMenu
@onready var fade_rect = $FadeRect

func _ready():
	# Garante que o FadeRect comece invisível
	var c = fade_rect.modulate
	c.a = 0.0
	fade_rect.modulate = c
	fade_rect.visible = true

func _input(event):
	if event.is_action_pressed("Menu_Game"):
		toggle_pause()

func toggle_pause():
	get_tree().paused = not get_tree().paused
	pause_menu.visible = get_tree().paused

func _on_resume_button_pressed():
	toggle_pause()

func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://inicio.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _process(_delta: float) -> void:
	pass

func _on_pressed() -> void:
	get_tree().quit()

func voltar_on_pressed() -> void:
	get_tree().change_scene_to_file("res://inicio.tscn")

func _on_texture_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://configuracoes.tscn")

func _on_texture_button_3_pressed() -> void:
	await fade_out()
	get_tree().change_scene_to_file("res://node_2d.tscn")

func fade_out() -> void:
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 1.0)
	await tween.finished


func _on_sair_button_pressed() -> void:
	get_tree().quit()
