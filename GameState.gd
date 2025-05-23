extends Node

var current_save_path := ""  # Caminho completo do save atual

var save_data := {
	"player_position": Vector2(100, 100),
	"money": 0,
	"inventory": []
}

func salvar_dados():
	if current_save_path == "":
		printerr("Caminho de save não definido!")
		return

	var file = FileAccess.open(current_save_path, FileAccess.ModeFlags.WRITE)
	if file:
		file.store_line(JSON.stringify(save_data))
		file.close()
		print("💾 [Autosave] Dados salvos em:", current_save_path)
		print("📍 Posição:", save_data["player_position"])
		print("💰 Dinheiro:", save_data["money"])
		print("🎒 Inventário:", save_data["inventory"])
	else:
		printerr("Erro ao abrir o arquivo para salvar.")
