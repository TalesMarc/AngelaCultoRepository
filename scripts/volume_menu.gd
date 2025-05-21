extends Control

@onready var volume_slider = $HBoxContainer/VolumeSlider
@onready var volume_label = $HBoxContainer/VolumePercentLabel

func _ready():
	# Carrega o volume salvo (ou usa 100%)
	var saved_volume = load_volume()
	volume_slider.value = saved_volume
	update_volume(saved_volume)

func _on_volume_slider_value_changed(value):
	update_volume(value)
	save_volume(value)

func update_volume(value: float):
	# Aplica volume global (de 0.0 a 1.0 convertido em dB)
	var db_volume = linear_to_db(value / 100.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), db_volume)

	# Atualiza texto da porcentagem
	volume_label.text = str(int(value)) + " %"

func save_volume(value: float):
	var config = ConfigFile.new()
	config.set_value("audio", "volume", value)
	config.save("user://settings.cfg")

func load_volume() -> float:
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK and config.has_section_key("audio", "volume"):
		return config.get_value("audio", "volume")
	return 100.0  # valor padrão


func _on_back_pressed() -> void:
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://cenas/inicio_menu.tscn")
