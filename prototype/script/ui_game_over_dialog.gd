extends WindowDialog


func _on_Button_pressed() -> void:
	if get_tree().paused:
		get_tree().paused = false
	LVL_MASTER.clear_all_stats()
	var current_lvl = LVL_MASTER.player_info["current_lvl_index"]
	#warning-ignore:return_value_discarded
	get_tree().change_scene(LVL_MASTER.lvl_path(current_lvl))


func _on_Button2_pressed() -> void:
	if get_tree().paused:
		get_tree().paused = false
	SOUND_FX.button_play("back/cancel")
	var lvl_selection = "res://lvls/end_menu.tscn"
	#warning-ignore:return_value_discarded
	get_tree().change_scene(lvl_selection)
