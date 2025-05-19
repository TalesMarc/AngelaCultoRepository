extends Node2D

func _ready():
	$VideoPlayer.play()
	

func _on_VideoPlayer_finished():
	
	get_tree().change_scene_to_file("res://cenas/inicio_menu.tscn")
