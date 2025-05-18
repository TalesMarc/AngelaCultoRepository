extends Node2D  # ou Control, conforme sua cena principal

@onready var pause_menu = $PauseMenu
@onready var fundo_animado = $Caminho/AnimatedSprite2D  # Ajuste o caminho real!

func _ready():
	# Inicializa o menu de pausa como invisível e sem foco
	if is_instance_valid(pause_menu):
		pause_menu.visible = false
		if pause_menu is Control:
			pause_menu.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _input(event):
	if event.is_action_pressed("Menu_Game"):
		toggle_pause_menu()

func toggle_pause_menu():
	if is_instance_valid(pause_menu):
		pause_menu.visible = not pause_menu.visible
		if pause_menu is Control:
			if pause_menu.visible:
				pause_menu.grab_focus()
				pause_menu.mouse_filter = Control.MOUSE_FILTER_STOP
				# Para pausar o jogo, você pode fazer:
				get_tree().paused = true
			else:
				# Retoma o jogo
				get_tree().paused = false
				pause_menu.mouse_filter = Control.MOUSE_FILTER_IGNORE
				# Aqui pode devolver foco a algum elemento do jogo, se quiser

# Função ligada ao botão "Continuar" do menu pausa
func _on_resume_button_pressed():
	toggle_pause_menu()  # fecha o menu e retoma o jogo

# Função ligada ao botão "Menu Principal"
func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://inicio.tscn")

# Função ligada ao botão "Sair"
func _on_quit_button_pressed():
	get_tree().quit()

# Caso tenha outros botões com funções específicas, mantenha ou ajuste
func _on_texture_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://inicio.tscn")

func _on_texture_button_pressed666() -> void:
	pause_menu.visible = not pause_menu.visible

# --- Handlers para interação (comentei para você preencher) ---

func _on_interact_area_body_entered(body: Node2D) -> void:
	# Aqui você deve tratar quando o player entrar na área de interação
	# Exemplo simples:
	if body == get_node("../Player"):  # ajuste o caminho para o nó player
		print("Player entrou na área de interação")
		# Você pode setar variáveis para interagir no player

func _on_interact_area_body_exited(body: Node2D) -> void:
	# Quando o player sair da área
	if body == get_node("../Player"):  # ajuste o caminho
		print("Player saiu da área de interação")
		# Limpe variáveis ou estados de interação aqui
