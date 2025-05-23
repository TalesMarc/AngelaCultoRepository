extends TextureButton

func _ready():
	self.mouse_entered.connect(_on_mouse_entered)
	self.pressed.connect(_on_pressed)

func _on_mouse_entered():
	var parent_node = get_parent()
	var som_node = parent_node.get_node("hover_sound")
	if som_node:
		som_node.play()

func _on_pressed():
	var parent_node = get_parent()
	
	# Pega o nome do LineEdit
	var line_edit = parent_node.get_node("LineEdit")
	if line_edit == null:
		push_error("LineEdit não encontrado!")
		return
	
	var nome_save = line_edit.text.strip_edges()
	if nome_save == "":
		print("Digite um nome válido.")
		return
	
	# Cria diretório de saves se não existir
	var save_dir = "user://saves"
	var dir_access = DirAccess.open("user://")
	if not dir_access.dir_exists("saves"):
		dir_access.make_dir("saves")
	
	var save_path = save_dir + "/" + nome_save + ".json"
	if FileAccess.file_exists(save_path):
		print("Já existe um save com esse nome!")
		return
	
	# Dados iniciais do save
	var data = {
		"player_position": [100, 100],
		"money": 0,
		"inventory": []
	}
	
	# Cria o arquivo JSON
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()
	print("Save criado: ", save_path)
	
	# Armazena no GameState
	GameState.current_save_path = save_path
	GameState.save_data = data
	
	# Música e transição
	var musica = parent_node.get_node("Musica1")
	if musica:
		musica.fade_out()
	
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://cenas/gameplay1.tscn")
