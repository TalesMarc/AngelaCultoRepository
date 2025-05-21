extends Control  # Ou Node2D

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
		if arquivo.ends_with(".save"):
			var nome_save = arquivo.replace(".save", "")
			
			var btn = button_model.duplicate()
			btn.visible = true
			btn.name = nome_save

			# Define o texto no Label interno
			var label = btn.get_node("TextoLabel")
			label.text = nome_save

			# Conecta o clique no botão
			btn.pressed.connect(func(): _on_save_button_pressed(nome_save))

			saves_list.add_child(btn)

		arquivo = dir.get_next()
	dir.list_dir_end()

func _on_save_button_pressed(nome_save: String):
	print("Botão do save pressionado: ", nome_save)
	# Aqui você pode adicionar o carregamento do save
	pass

func _on_back_pressed() -> void:
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://cenas/inicio_menu.tscn")
