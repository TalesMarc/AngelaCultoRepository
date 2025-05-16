extends Node2D # Ou Control, dependendo do nó principal da sua cena de jogo

@onready var options_menu = $OptionsMenu # Assumindo que seu menu de opções se chama "OptionsMenu"

func _ready():
	# Certifica-se de que o menu de opções esteja inicialmente invisível
	if is_instance_valid(options_menu):
		options_menu.visible = false

func _input(event):
	if event.is_action_pressed("Menu_Game"): # Mantemos a mesma ação para o Esc
		toggle_options_menu()

func toggle_options_menu():
	if is_instance_valid(options_menu):
		options_menu.visible = not options_menu.visible

func _on_resume_button_pressed():
	toggle_options_menu() # Fecha o menu de opções (se você tiver um botão de "Voltar")

func _on_main_menu_button_pressed():
	# Aqui você colocaria a lógica para ir para o menu principal
	get_tree().change_scene_to_file("res://inicio.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
