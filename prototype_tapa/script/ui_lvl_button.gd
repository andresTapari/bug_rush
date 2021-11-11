extends Control

export var index: int = 1

func _ready() -> void:
	$Button/VBoxContainer/Label_lvl.text = "Lvl: " + String(index)

# Funciones
func update_status(_index):
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
