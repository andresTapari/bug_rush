extends WindowDialog

#Nodos:
#|_>check_box:
onready var CB_full_screen 		= get_node('MarginContainer/VBoxContainer/HBoxContainer/CB_full_screen')
onready var buttons_sounds_en 	= get_node('MarginContainer/VBoxContainer/button_sounds_en') 
onready var sound_effects_en  	= get_node('MarginContainer/VBoxContainer/sound_effects_en')
onready var music_en 			= get_node('MarginContainer/VBoxContainer/music_en')

#|_>sliders:
onready var buttons_vol_slider 	= get_node('MarginContainer/VBoxContainer/bs_HSlider')
onready var fx_vol_slider		= get_node('MarginContainer/VBoxContainer/fx_HSlider')
onready var music_slider		= get_node('MarginContainer/VBoxContainer/music_HSlider')

func _ready() -> void:
	load_current_values()

func load_current_values() ->void :
	CB_full_screen.pressed 		= SETUP.current["full_screen_en"]
	buttons_sounds_en.pressed 	= SETUP.current["button_sound_en"]
	sound_effects_en.pressed 	= SETUP.current["sound_effect_en"]
	music_en.pressed			= SETUP.current["music_en"]
	buttons_vol_slider.value	= SETUP.current["button_sound_vol"]
	fx_vol_slider.value			= SETUP.current["effect_sound_vol"]
	music_slider.value			= SETUP.current["music_vol"]

func load_default_values() ->void :
	CB_full_screen.pressed 		= SETUP.default["full_screen_en"]
	buttons_sounds_en.pressed 	= SETUP.default["button_sound_en"]
	sound_effects_en.pressed 	= SETUP.default["sound_effect_en"]
	music_en.pressed			= SETUP.default["music_en"]
	buttons_vol_slider.value	= SETUP.default["button_sound_vol"]
	fx_vol_slider.value			= SETUP.default["effect_sound_vol"]
	music_slider.value			= SETUP.default["music_vol"]

func _on_Button_pressed() -> void:
	SOUND_FX.button_play("back/cancel")
	load_default_values()

func button_sound(value:bool) -> void:
	if value:
		SOUND_FX.button_play("acept")
	else:
		SOUND_FX.button_play("back/cancel")

# Señales:
func _on_CB_full_screen_toggled(button_pressed: bool) -> void:
	SETUP.current["full_screen_en"] = button_pressed
	button_sound(button_pressed)
	OS.window_fullscreen = button_pressed

func _on_button_sounds_en_toggled(button_pressed: bool) -> void:
	SETUP.current["button_sound_en"] = button_pressed
	button_sound(button_pressed)
	buttons_vol_slider.editable = button_pressed
	AudioServer.set_bus_mute(1, !button_pressed)

func _on_sound_effects_en_toggled(button_pressed: bool) -> void:
	SETUP.current["sound_effect_en"] = button_pressed
	button_sound(button_pressed)
	fx_vol_slider.editable = button_pressed
	AudioServer.set_bus_mute(2, !button_pressed)
	
func _on_music_en_toggled(button_pressed: bool) -> void:
	SETUP.current["music_en"] = button_pressed
	button_sound(button_pressed)
	music_slider.editable = button_pressed
	AudioServer.set_bus_mute(3, !button_pressed)

func _on_bs_HSlider_value_changed(value: float) -> void:
	SETUP.current["button_sound_vol"] = value
	AudioServer.set_bus_volume_db(1,linear2db(value))

func _on_fx_HSlider_value_changed(value: float) -> void:
	SETUP.current["effect_sound_vol"] = value
	AudioServer.set_bus_volume_db(2,linear2db(value))

func _on_music_HSlider_value_changed(value: float) -> void:
	SETUP.current["music_vol"] = value
	AudioServer.set_bus_volume_db(3,linear2db(value))

func _on_Button2_pressed() -> void:
	hide()
