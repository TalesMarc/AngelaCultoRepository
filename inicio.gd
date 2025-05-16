extends Control



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_pressed() -> void:
	get_tree().quit()


func voltar_on_pressed() -> void:
	get_tree().change_scene_to_file("res://inicio.tscn")


func _on_texture_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://configuracoes.tscn")


func _on_texture_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://node_2d.tscn")
