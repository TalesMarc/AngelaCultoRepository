extends TextureButton

func _ready():
	self.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	var gameplay = get_tree().current_scene
	if gameplay and gameplay.has_method("_update_game_state") and gameplay.has_method("_save_game_data"):
		gameplay._update_game_state()
		gameplay._save_game_data()
		print("Jogo salvo instantaneamente pelo botão!")
	else:
		push_error("Funções de save não encontradas na cena atual.")
