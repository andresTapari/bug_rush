extends Control

func _ready() -> void:
	if LVL_MASTER.player_info["current_lvl_index"] != 1:
		$MarginContainer/VBoxContainer/Button_continue.disabled = false

# Señales:
func _on_Button_play_pressed() -> void:
	SOUND_FX.button_play("acept")
	var current_lvl = LVL_MASTER.player_info["current_lvl_index"]
	#warning-ignore:return_value_discarded
	get_tree().change_scene(LVL_MASTER.lvl_path(current_lvl))
	

func _on_Button_lvl_selection_pressed() -> void:
	SOUND_FX.button_play("acept")
	var lvl_selection = "res://lvls/lvl_selection.tscn"
	#warning-ignore:return_value_discarded
	get_tree().change_scene(lvl_selection)

func _on_Button_exit_pressed() -> void:
	SOUND_FX.button_play("back/cancel")
	# Guardar progreso
	get_tree().quit()

func _on_Button_setup_pressed() -> void:
	$Setup_dialog.popup_centered()
	SOUND_FX.button_play("acept")

func _on_Button_new_game_pressed() -> void:
	LVL_MASTER.clear_all_stats()
	var current_lvl = LVL_MASTER.player_info["current_lvl_index"]
	#warning-ignore:return_value_discarded
	get_tree().change_scene(LVL_MASTER.lvl_path(current_lvl))
