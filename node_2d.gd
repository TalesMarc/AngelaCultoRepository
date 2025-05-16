extends Node2D # ou Control, dependendo do nó ao qual o script está anexado

@onready var pause_menu = $PauseMenu

func _input(event):
	if event.is_action_pressed("Menu_Game"):
		print("Na cena do jogo: Ação Menu_Game pressionada")
		toggle_pause()

func toggle_pause():
	get_tree().paused = not get_tree().paused
	print("Na cena do jogo: Estado de pausa alterado para:", get_tree().paused)
	pause_menu.visible = get_tree().paused
	print("Na cena do jogo: Visibilidade do menu de pausa:", pause_menu.visible)

func _on_resume_button_pressed():
	toggle_pause()
	print("Na cena do jogo: Botão de resume pressionado")

func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://inicio.tscn")
	print("Na cena do jogo: Botão de menu principal pressionado")

func _on_quit_button_pressed():
	get_tree().quit()
	print("Na cena do jogo: Botão de sair pressionado")
