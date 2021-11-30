extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/VBoxContainer/Score.text = "Score: " + String(LVL_MASTER.get_total_score())
	if LVL_MASTER.player_info["victory_flag"] == true:
		$MarginContainer/VBoxContainer/Title.text = "YOU WIN!!!"
	else:
		$MarginContainer/VBoxContainer/Title.text = "GAME OVER"

func _on_Button_pressed() -> void:
	SOUND_FX.button_play("back/cancel")
	var lvl_selection = "res://lvls/main_menu.tscn"
	#warning-ignore:return_value_discarded
	get_tree().change_scene(lvl_selection)


func _on_RichTextLabel_meta_clicked(meta) -> void:
		OS.shell_open(meta)


func _on_Button_exit_pressed() -> void:
	SOUND_FX.button_play("back/cancel")
	# Guardar progreso
	get_tree().quit()
