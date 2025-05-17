extends Control

var caller_node: Node = null  # Guarda o nó que chamou

func voltar_on_pressed() -> void:
	queue_free()  # Fecha esta cena

	if caller_node != null:
		caller_node.visible = true  # Reexibe o menu anterior
