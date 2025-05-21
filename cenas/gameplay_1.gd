extends Node2D  # Seu nó principal

@onready var menu_layer = $Personagens/Persona1/Control  # Ajuste o caminho se for diferente

func _ready():
	menu_layer.visible = false  # começa invisível

func _unhandled_input(event):
	if event.is_action_pressed("menu"):  # tecla "menu" no InputMap, tipo ESC
		menu_layer.visible = not menu_layer.visible  # alterna visibilidade do menu


func _on_quit_pressed() -> void:
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://cenas/inicio_menu.tscn")
