extends Control

export var index: int = 1

func _ready() -> void:
	$Button/VBoxContainer/Label_lvl.text = "Lvl: " + String(index)

# Funciones
func update_status(_index):
	if _index <= LVL_MASTER.player_info["current_lvl"]:
		$Button.disabled = false
	var dictionary = LVL_MASTER.lvl_info(_index)
	var msg: String = String(dictionary["score"]) + "/" \
						+ " $"+ String(dictionary["coins"])
	$Button/VBoxContainer/Label_score_coin.text = msg
	if dictionary["stars"] >= 1:
		$Button/VBoxContainer/HBoxContainer/CheckBox.pressed = true
	if dictionary["stars"] >= 2:
		$Button/VBoxContainer/HBoxContainer/CheckBox2.pressed = true
	if dictionary["stars"] >= 3:
		$Button/VBoxContainer/HBoxContainer/CheckBox3.pressed = true


func _on_Button_pressed() -> void:
	var lvl_path: String = ""
	lvl_path = LVL_MASTER.lvl_path(index)
	#warning-ignore:return_value_discarded
	get_tree().change_scene(lvl_path)
