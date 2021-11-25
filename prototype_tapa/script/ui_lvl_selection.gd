extends Control


func _ready() -> void:
	var buttons = $MarginContainer/GridContainer.get_children()
	var i: int = 0
	for item in buttons:
		i += 1
		item.update_status(i)

func _on_Button_main_menu_pressed() -> void:
	SOUND_FX.button_play("back/cancel")
	var main_menu = "res://lvls/main_menu.tscn"
	#warning-ignore:return_value_discarded
	get_tree().change_scene(main_menu)
