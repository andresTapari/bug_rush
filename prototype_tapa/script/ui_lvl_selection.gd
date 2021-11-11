extends Control



func _on_Button_main_menu_pressed() -> void:
	var main_menu = "res://lvls/main_menu.tscn"
	get_tree().change_scene(main_menu)
