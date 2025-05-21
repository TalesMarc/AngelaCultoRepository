extends Node

var musica_player: AudioStreamPlayer
var fade_timer: Timer = null
var fade_duration := 2.0  # duração do fade out em segundos
var fade_elapsed := 0.0

func _ready():
	musica_player = AudioStreamPlayer.new()
	musica_player.stream = preload("res://ImagensMusSolo/demo_menu.mp3")  # Ajuste para seu arquivo
	musica_player.volume_db = -5
	add_child(musica_player)
	musica_player.play()
	
	# Conecta o sinal 'finished' para tocar de novo quando acabar
	musica_player.connect("finished", Callable(self, "_on_musica_finished"))

func _on_musica_finished():
	musica_player.play()

func tocar():
	if not musica_player.playing:
		musica_player.play()

func parar():
	if musica_player.playing:
		musica_player.stop()

func fade_out():
	if fade_timer == null:
		fade_timer = Timer.new()
		fade_timer.wait_time = 0.05  # intervalo de 50ms para o fade
		fade_timer.one_shot = false
		fade_timer.connect("timeout", Callable(self, "_on_fade_tick"))
		add_child(fade_timer)
	fade_elapsed = 0.0
	fade_timer.start()

func _on_fade_tick():
	fade_elapsed += fade_timer.wait_time
	var t = fade_elapsed / fade_duration
	# Volume vai de -5 dB (inicial) até -80 dB (silêncio quase total)
	musica_player.volume_db = lerp(-5, -80, t)
	
	if t >= 1.0:
		fade_timer.stop()
		musica_player.stop()
		musica_player.volume_db = -5  # reseta volume para próxima vez
