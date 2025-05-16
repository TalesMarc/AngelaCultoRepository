extends Node2D  # ou Control, dependendo de onde você estiver

@onready var pause_menu = $PauseMenu

func _ready():
	process_mode = Node.ProcessModeEnum.PROCESS
	pause_menu.visible = false  # Começa invisível

func _input(event):
	if event.is_action_pressed("Menu_Game"):
		toggle_pause()

func toggle_pause():
	if get_tree().paused:
		# Se já está pausado, despausa e esconde menu
		get_tree().paused = false
		pause_menu.visible = false
	else:
		# Se não está pausado, pausa e mostra menu
		get_tree().paused = true
		pause_menu.visible = true

func _on_resume_button_pressed():
	toggle_pause()

func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://inicio.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
