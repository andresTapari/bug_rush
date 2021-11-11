extends Control

func _ready() -> void:
#	current_lvl = LVL_MASTER.player_info["current_lvl"]
	pass

# Señales:
func _on_Button_play_pressed() -> void:
	var current_lvl = LVL_MASTER.player_info["current_lvl"]
	get_tree().change_scene(LVL_MASTER.lvl_path(current_lvl))

func _on_Button_lvl_selection_pressed() -> void:
	var lvl_selection = "res://lvls/lvl_selection.tscn"
	get_tree().change_scene(lvl_selection)


func _on_Button_exit_pressed() -> void:
	# Guardar progreso
	get_tree().quit()
