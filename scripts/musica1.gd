extends Node

var musica_player: AudioStreamPlayer
var fade_timer: Timer = null
var fade_duration := 2.0  # duração do fade out em segundos
var fade_elapsed := 0.0
var volume_inicial := -5.0  # volume padrão para tocar

func _ready():
	musica_player = AudioStreamPlayer.new()
	musica_player.stream = preload("res://ImagensMusSolo/demo_menu.mp3")
	musica_player.volume_db = volume_inicial
	add_child(musica_player)
	musica_player.play()

	musica_player.connect("finished", Callable(self, "_on_musica_finished"))

func _on_musica_finished():
	musica_player.play()

func tocar():
	if not musica_player.playing:
		musica_player.volume_db = volume_inicial
		musica_player.play()

func parar():
	if musica_player.playing:
		musica_player.stop()

func fade_out():
	if fade_timer != null and fade_timer.is_inside_tree():
		fade_timer.stop()
		fade_timer.queue_free()
	
	fade_timer = Timer.new()
	fade_timer.wait_time = 0.05
	fade_timer.one_shot = false
	fade_timer.connect("timeout", Callable(self, "_on_fade_tick"))
	add_child(fade_timer)

	fade_elapsed = 0.0
	fade_timer.start()

func _on_fade_tick():
	fade_elapsed += fade_timer.wait_time
	var t = fade_elapsed / fade_duration
	musica_player.volume_db = lerp(volume_inicial, -80.0, t)

	if t >= 1.0:
		fade_timer.stop()
		fade_timer.queue_free()
		fade_timer = null

		musica_player.stop()
		musica_player.volume_db = volume_inicial
