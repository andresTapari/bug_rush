extends WindowDialog

func _on_Button_main_menu_pressed():
	SOUND_FX.button_play("back/cancel")
	var lvl_selection = "res://lvls/main_menu.tscn"
	#warning-ignore:return_value_discarded
	get_tree().change_scene(lvl_selection)


func _on_Button_lvl_selection_pressed():
	SOUND_FX.button_play("acept")
	var lvl_selection = "res://lvls/lvl_selection.tscn"
	#warning-ignore:return_value_discarded
	get_tree().change_scene(lvl_selection)

func _on_Button_back_pressed():
	SOUND_FX.button_play("back/cancel")
	hide()

func _on_Button_setup_pressed() -> void:
	SOUND_FX.button_play("acept")
	$Setup_dialog.popup()
