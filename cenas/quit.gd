extends TextureButton

func _ready():
	self.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	var gameplay = get_tree().current_scene
	if gameplay and gameplay.has_method("_update_game_state") and gameplay.has_method("_save_game_data"):
		gameplay._update_game_state()
		gameplay._save_game_data()
		print("Jogo salvo. Retornando ao menu...")

		await get_tree().create_timer(0.5).timeout  # Aguarda brevemente o save
		get_tree().change_scene_to_file("res://cenas/inicio_menu.tscn")  # Certifique-se que esse caminho está correto
	else:
		push_error("Funções de save ou cena de menu não encontradas.")
