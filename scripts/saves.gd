extends Control

@onready var saves_list = $ScrollContainer/VBoxContainer
@onready var button_model = saves_list.get_node("BotaoModelo")

func _ready():
	atualizar_lista_saves()

func limpar_vbox():
	for filho in saves_list.get_children():
		if filho != button_model:
			filho.queue_free()

func atualizar_lista_saves():
	limpar_vbox()

	var dir = DirAccess.open("user://saves")
	if not dir or not dir.dir_exists("user://saves"):
		print("Pasta de saves não existe.")
		return
	
	dir.list_dir_begin()
	var arquivo = dir.get_next()
	while arquivo != "":
		if arquivo.ends_with(".save") or arquivo.ends_with(".json"):
			var nome_save = arquivo.get_basename()

			var btn = button_model.duplicate()
			btn.visible = true
			btn.name = nome_save

			var label = btn.get_node("TextoLabel")
			label.text = nome_save

			btn.pressed.connect(func(): _on_save_button_pressed(nome_save))

			saves_list.add_child(btn)
		arquivo = dir.get_next()
	dir.list_dir_end()

func _on_save_button_pressed(nome_save: String):
	print("Carregando save:", nome_save)
	
	var path = "user://saves/" + nome_save + ".json"
	if not FileAccess.file_exists(path):
		push_error("Arquivo de save não encontrado: " + path)
		return

	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()

	var parsed = JSON.parse_string(content)
	if typeof(parsed) != TYPE_DICTIONARY:
		push_error("Erro ao interpretar JSON.")
		return

	GameState.current_save_path = path
	GameState.save_data = parsed

	get_tree().change_scene_to_file("res://cenas/gameplay1.tscn")

func _on_back_pressed():
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://cenas/inicio_menu.tscn")
