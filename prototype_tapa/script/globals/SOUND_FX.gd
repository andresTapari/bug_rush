extends Node

# Music:
# Jeremy Blake - Powerup! ♫ NO COPYRIGHT 8-bit Music
# https://www.youtube.com/watch?v=l7SwiFWOQqM

onready var button_sound
onready var music_player

func _ready() -> void:
	self.set_pause_mode(2) # Set pause mode to Process
	# Creamos un nodo AudioSetramPlayer
	button_sound = AudioStreamPlayer.new()
	button_sound.set_bus("Buttons")
	self.add_child(button_sound)
	music_player = AudioStreamPlayer.new()
	music_player.set_bus("Music")
	music_player.stream =  load("res://assets/music/Jeremy Blake - Powerup!.mp3")
	music_player.play()
	music_player.connect('finished',self,'handle_music_stop')
	self.add_child(music_player)
	
func button_play(media: String)->void:
	match media:
			"acept":
				button_sound.stream = load("res://assets/sounds/button_sound_acept.wav")
				button_sound.play()
			"back/cancel":
				button_sound.stream = load("res://assets/sounds/button_sound_back_cancel.wav")
				button_sound.play()

func handle_music_stop() -> void:
	music_player.play()
