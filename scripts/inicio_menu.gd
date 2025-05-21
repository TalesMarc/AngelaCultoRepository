extends Node2D


func _ready():
	$FadeLayer/FadeAnimation.play("fade_in")


func _on_settings_button_pressed() -> void:
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://cenas/config_menu.tscn")


func _on_quit_button_pressed() -> void:
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()


func _on_saves_button_pressed() -> void:
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://cenas/saves.tscn")


func _on_play_button_pressed() -> void:
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://cenas/name_play.tscn")
