extends Node

onready var button_sound

func _ready() -> void:
	self.set_pause_mode(2) # Set pause mode to Process
	# Creamos un nodo AudioSetramPlayer
	button_sound = AudioStreamPlayer.new()
	button_sound.set_bus("Buttons")
	self.add_child(button_sound)

func button_play(media: String)->void:
	match media:
			"acept":
				button_sound.stream = load("res://assets/sounds/button_sound_acept.wav")
				button_sound.play()
			"back/cancel":
				button_sound.stream = load("res://assets/sounds/button_sound_back_cancel.wav")
				button_sound.play()
