extends Node2D  # ou Control, dependendo de onde você estiver

@onready var pause_menu = $PauseMenu

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
