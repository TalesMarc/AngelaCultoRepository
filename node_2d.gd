extends Node2D # Ou Control, dependendo do nó principal da sua cena de jogo

@onready var pause_menu = $PauseMenu
var is_paused = false

func _ready():
	# Certifica-se de que o menu de pausa esteja inicialmente invisível
	if is_instance_valid(pause_menu):
		pause_menu.visible = false
		# Se pause_menu for um Control, desativa o foco inicial
		if pause_menu is Control:
			pause_menu.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _input(event):
	if event.is_action_pressed("Menu_Game"):
		toggle_pause()

func toggle_pause():
	is_paused = not is_paused
	get_tree().paused = is_paused
	if is_instance_valid(pause_menu):
		pause_menu.visible = is_paused
		# Se pause_menu for um Control, gerencia o foco
		if pause_menu is Control:
			if is_paused:
				pause_menu.grab_focus()
				pause_menu.mouse_filter = Control.MOUSE_FILTER_STOP
			else:
				# Opcional: devolve o foco para algum elemento do jogo se necessário
				# get_node("NomeDoElementoDoJogo").grab_focus()
				pause_menu.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_resume_button_pressed():
	toggle_pause()

func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://inicio.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
