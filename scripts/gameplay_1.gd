extends Node2D  # Nó principal da cena de gameplay

@onready var menu_layer = $Personagens/Persona1/Camera2D/Control
@onready var personagem = $Personagens/Persona1
var autosave_timer: Timer = null


func _ready():
	menu_layer.visible = false
	personagem.speed = 100.0

	# Carrega os dados do save
	_load_game_data()

	# Inicia autosave a cada 60 segundos
	autosave_timer = Timer.new()
	autosave_timer.wait_time = 60.0
	autosave_timer.one_shot = false
	autosave_timer.autostart = true
	autosave_timer.timeout.connect(_on_autosave)
	add_child(autosave_timer)

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		menu_layer.visible = not menu_layer.visible
		personagem.speed = 0.0 if menu_layer.visible else 100.0

func _load_game_data():
	if GameState.save_data.size() == 0:
		push_error("Nenhum dado de save carregado.")
		return

	var data = GameState.save_data

	if "player_position" in data:
		personagem.global_position = Vector2(data["player_position"][0], data["player_position"][1])

func _on_autosave():
	print("Autosave executado")
	_update_game_state()
	_save_game_data()

func _update_game_state():
	GameState.save_data["player_position"] = [personagem.global_position.x, personagem.global_position.y]

func _save_game_data():
	if GameState.current_save_path == "":
		push_error("Caminho de save não definido.")
		return
	
	var file = FileAccess.open(GameState.current_save_path, FileAccess.WRITE)
	if file:
		var json = JSON.new()
		file.store_string(json.stringify(GameState.save_data))
		file.close()
		print("Dados salvos em: ", GameState.current_save_path)
	else:
		push_error("Falha ao abrir arquivo para salvar.")
