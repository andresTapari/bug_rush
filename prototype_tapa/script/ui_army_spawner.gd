extends WindowDialog


#Señales:
signal spawn_units(army_list)
signal attack_started

# Nodos:
onready var unit_list   = get_node('MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer')
onready var label_coins = get_node('MarginContainer/VBoxContainer/HBoxContainer/Label_coins_counter')


func _ready() -> void:
#	popup()
	handle_update_coins_counter()
	var units_btn_list = unit_list.get_children()
	for item in units_btn_list:
		if item is MarginContainer:
			item.connect('update_coins_counter',self,"handle_update_coins_counter")

# Funciones:
func handle_update_coins_counter():
	label_coins.text = String(LVL_MASTER.player_info["coins"])

# Señales:
func _on_Button_pressed():
	SOUND_FX.button_play("acept")
	var army_list: Array = Array()
	var units_btn_list = unit_list.get_children()
	for item in units_btn_list:
		if item is MarginContainer:
			var value = item.get_unit_info()
			army_list.push_back(value)
	#Signal self -> Spawner_player
	emit_signal("spawn_units",army_list)
	emit_signal("attack_started")
	hide()
