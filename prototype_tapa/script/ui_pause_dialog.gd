extends WindowDialog

signal show_setup_dialog
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Button_main_menu_pressed():
	var lvl_selection = "res://lvls/main_menu.tscn"
	#warning-ignore:return_value_discarded
	get_tree().change_scene(lvl_selection)


func _on_Button_lvl_selection_pressed():
	var lvl_selection = "res://lvls/lvl_selection.tscn"
	#warning-ignore:return_value_discarded
	get_tree().change_scene(lvl_selection)

func _on_Button_back_pressed():
	hide()

func _on_Button_setup_pressed() -> void:
	$Setup_dialog.popup()
