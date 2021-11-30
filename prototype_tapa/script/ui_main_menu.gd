extends Control

func _ready() -> void:
	if LVL_MASTER.player_info["current_lvl_index"] != 1:
		$MarginContainer/VBoxContainer/Button_continue.disabled = false
	if LVL_MASTER.player_info["coins"] == 0:
		$MarginContainer/VBoxContainer/Button_continue.disabled = true
		$MarginContainer/VBoxContainer/Button_lvl_selection.disabled = true
	
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
	var lvl_selection = "res://lvls/end_menu.tscn"
	#warning-ignore:return_value_discarded
	get_tree().change_scene(lvl_selection)

func _on_Button_setup_pressed() -> void:
	$Setup_dialog.popup_centered()
	SOUND_FX.button_play("acept")

func _on_Button_new_game_pressed() -> void:
	LVL_MASTER.clear_all_stats()
	var current_lvl = LVL_MASTER.player_info["current_lvl_index"]
	#warning-ignore:return_value_discarded
	get_tree().change_scene(LVL_MASTER.lvl_path(current_lvl))


func _on_git_repo_meta_clicked(meta) -> void:
	#warning-ignore:return_value_discarded
	OS.shell_open(meta)


func _on_godot_engine_meta_clicked(meta) -> void:
	#warning-ignore:return_value_discarded
	OS.shell_open(meta)
