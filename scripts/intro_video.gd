extends Node2D

func _ready():
	$VideoPlayer.play()
	carregar_configuracoes()
	Musica1.tocar()

func carregar_configuracoes():
	var config_scene = preload("res://cenas/config_menu.tscn")  # ajuste se estiver em outro local
	var config_instance = config_scene.instantiate()
	
	config_instance.visible = false  # Oculta visualmente
	add_child(config_instance)       # Adiciona à árvore para rodar _ready()

	# Aguarda um tempo para garantir que o _ready() da cena rode antes de removê-la
	await get_tree().create_timer(0.5).timeout
	config_instance.queue_free()

func _on_VideoPlayer_finished():
	get_tree().change_scene_to_file("res://cenas/inicio_menu.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/inicio_menu.tscn")
	
	
