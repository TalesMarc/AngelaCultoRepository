extends Node2D # Ou Control, dependendo do nó principal da sua cena de jogo

@onready var pause_menu = $CanvasLayer/PauseMenu # Ajuste o caminho SE necessário
var is_paused = false

func _ready():
	if is_instance_valid(pause_menu):
		pause_menu.visible = false

func _input(event):
	if event.is_action_pressed("Menu_Game"):
		toggle_pause()

func toggle_pause():
	is_paused = not is_paused
	get_tree().paused = is_paused
	if is_instance_valid(pause_menu):
		pause_menu.visible = is_paused
		# Se houver um nó Control dentro do seu CanvasLayer que deve receber o foco:
		# var algum_control = pause_menu.get_node("NomeDoControl")
		# if is_instance_valid(algum_control) and algum_control is Control:
		# 	if is_paused:
		# 		algum_control.grab_focus()

func _on_resume_button_pressed():
	toggle_pause()

func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://inicio.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
