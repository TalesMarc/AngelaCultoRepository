extends Node2D  # Ou Control, dependendo do seu nó principal

@onready var pause_menu = $PauseMenu

func _ready():
	# Permite que esse nó receba inputs mesmo quando o jogo está pausado
	pause_mode = Node.PAUSE_MODE_PROCESS
	
	# Garante que o menu começa invisível
	pause_menu.visible = false

func _input(event):
	if event.is_action_pressed("Menu_Game"):  # Sua ação configurada para ESC
		toggle_pause()

func toggle_pause():
	var is_paused = get_tree().paused
	get_tree().paused = not is_paused
	pause_menu.visible = not is_paused

# Botões do menu de pausa — conecte os sinais 'pressed' deles para esses métodos

func _on_resume_button_pressed():
	toggle_pause()

func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://inicio.tscn")  # Troque para sua cena principal

func _on_quit_button_pressed():
	get_tree().quit()
