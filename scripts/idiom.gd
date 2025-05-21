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
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://cenas/gameplay1.tscn")
	var parent_node = get_parent()
	
	# Pega o LineEdit
	var line_edit = parent_node.get_node("LineEdit")
	if line_edit == null:
		push_error("LineEdit não encontrado!")
		return
	
	var nome_save = line_edit.text.strip_edges()
	if nome_save == "":
		print("Por favor, digite um nome válido.")
		return
	
	# Diretório para saves
	var save_dir = "user://saves"
	var dir_access = DirAccess.open("user://")
	if not dir_access.dir_exists("saves"):
		var err = dir_access.make_dir("saves")
		if err != OK:
			push_error("Erro ao criar diretório de saves")
			return
	
	var save_path = save_dir + "/" + nome_save + ".save"
	if FileAccess.file_exists(save_path):
		print("Já existe um save com esse nome!")
		return
	
	var file = FileAccess.open(save_path, FileAccess.ModeFlags.WRITE)
	if file == null:
		push_error("Erro ao criar o save.")
		return
	
	file.store_line("Save de " + nome_save)
	file.close()
	
	print("Save criado com sucesso: ", nome_save)
	
	# Fade out música
	if parent_node.has_node("Musica1"):
		var musica = parent_node.get_node("Musica1")
		if musica.has_method("fade_out"):
			musica.fade_out()
	
	# Toca som de clique
	var som_node = parent_node.get_node("click_sound")
	if som_node:
		som_node.play()
