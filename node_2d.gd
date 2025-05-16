extends Node2D # Ou Control, dependendo do nó principal da sua cena de jogo

@onready var pause_menu = $PauseMenu

func _ready():
	# Certifica-se de que o menu de pausa esteja inicialmente invisível
	if is_instance_valid(pause_menu):
		pause_menu.visible = false
		# Se pause_menu for um Control, desativa o foco inicial
		if pause_menu is Control:
			pause_menu.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _input(event):
	if event.is_action_pressed("Menu_Game"):
		toggle_pause_menu() # Renomeei a função para deixar mais claro o propósito

func toggle_pause_menu():
	if is_instance_valid(pause_menu):
		pause_menu.visible = not pause_menu.visible
		# Se pause_menu for um Control, gerencia o foco
		if pause_menu is Control:
			if pause_menu.visible:
				pause_menu.grab_focus()
				pause_menu.mouse_filter = Control.MOUSE_FILTER_STOP
			else:
				# Opcional: devolve o foco para algum elemento do jogo se necessário
				# get_node("NomeDoElementoDoJogo").grab_focus()
				pause_menu.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_resume_button_pressed():
	toggle_pause_menu() # Agora fecha o menu, já que o jogo não está pausado

func _on_main_menu_button_pressed():
	# Aqui você colocaria a lógica para ir para o menu principal
	get_tree().change_scene_to_file("res://inicio.tscn")

func _on_quit_button_pressed():
	get_tree().quit()


func _on_texture_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://inicio.tscn")
