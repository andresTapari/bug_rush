extends WindowDialog

#Señales:
signal spawn_units(army_list)
signal send_total_units(total_units)
signal attack_started

# Nodos:
onready var unit_list   = get_node('MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer')
onready var label_coins = get_node('MarginContainer/VBoxContainer/HBoxContainer/Label_coins_counter')

# Variables:
var total_units: int = 0

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
	var army_list: Array = Array()
	var units_btn_list = unit_list.get_children()
	for item in units_btn_list:
		if item is MarginContainer:
			var value = item.get_unit_info()
			army_list.push_back(value)
			total_units += value["Amount"]
	#Signal self -> Spawner_player
	if total_units != 0:
		SOUND_FX.button_play("acept")
		emit_signal("spawn_units",army_list) #<-total units
		emit_signal("send_total_units",total_units)
		emit_signal('attack_started')
		hide()
	else:
		SOUND_FX.button_play("back/cancel")

func units_in_queue() -> bool:
	var units_btn_list = unit_list.get_children()
	for item in units_btn_list:
		if item is MarginContainer:
			var value = item.get_unit_info()
			total_units += value["Amount"]
	if total_units != 0:
		return true
	return false
