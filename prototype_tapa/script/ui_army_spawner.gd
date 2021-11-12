extends WindowDialog

onready var unit_list   = get_node('MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer')
onready var label_coins = get_node('MarginContainer/VBoxContainer/HBoxContainer/Label_coins_counter')
func _ready() -> void:
	popup()
	var units_btn_list = unit_list.get_children()
	for item in units_btn_list:
		if item is MarginContainer:
			item.connect('update_coins_counter',self,"handle_update_coins_counter")


func handle_update_coins_counter():
	label_coins.text = String(LVL_MASTER.player_info["coins"])
