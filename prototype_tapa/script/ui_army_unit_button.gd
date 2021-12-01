extends MarginContainer

export var unit_index: int = 1

var unit_number:int = 0
var unit_delay:int  = 0
var unit_cost:int   = 0
var unit_type

var stats: Dictionary 

signal update_coins_counter

# Nodos:
	#Labels:
onready var label_name   = get_node('HBoxContainer/VBoxContainer/HBoxContainer3/label_name')
onready var label_coins  = get_node('HBoxContainer/VBoxContainer/HBoxContainer3/coin_cost')
onready var label_atk    = get_node('HBoxContainer/VBoxContainer/HBoxContainer2/label_stats_atk')
onready var label_def    = get_node('HBoxContainer/VBoxContainer/HBoxContainer2/label_stats_def')
onready var label_arm    = get_node('HBoxContainer/VBoxContainer/HBoxContainer2/label_stats_arm')
onready var label_number = get_node('HBoxContainer/VBoxContainer/HBoxContainer/label_numbers')
onready var label_delay  = get_node('HBoxContainer/VBoxContainer/HBoxContainer/label_delay')
onready var icon_type    = get_node('HBoxContainer/TextureRect')
	#Buttons:
onready var btn_n_add	 = get_node('HBoxContainer/VBoxContainer/HBoxContainer/Button_amount_plus')
onready var btn_n_less	 = get_node('HBoxContainer/VBoxContainer/HBoxContainer/Button_amount_less')
onready var btn_del_add  = get_node('HBoxContainer/VBoxContainer/HBoxContainer/Button_delay_plus')
onready var btn_del_less = get_node('HBoxContainer/VBoxContainer/HBoxContainer/Button_delay_less')

func _ready() -> void:
	update_stats(unit_index)

# Funciones:
func update_stats(_index: int) -> void:
	unit_index = _index
	stats = UNIT_STATS.get_unit_stats(_index)
	unit_type		  = stats["Type"]
	label_name.text   = stats["Name"]
	label_coins.text  = String(stats["price"])
	label_atk.text	  = String(stats["Damage"])
	label_def.text    = String(stats["Health"])
	label_arm.text    = String(stats["Speed"])		#whe change to speed at last minute
	unit_cost 		  = stats["price"]
	icon_type.texture = load(stats["icon_path"])

func get_unit_info()-> Dictionary:
	var info:Dictionary = {
						"Type":unit_type,
						"Amount": unit_number,
						"Delay": unit_delay}
	return info

#Señales:
	# Amount:
func _on_Button_amount_plus_pressed() -> void:
	SOUND_FX.button_play("acept")
	if unit_cost <= LVL_MASTER.player_info["coins"]:
		unit_number += 1
		LVL_MASTER.player_info["coins"] -= unit_cost
		if unit_number > 0:
			btn_n_less.disabled = false
		label_number.text = String(unit_number)
	emit_signal('update_coins_counter')

func _on_Button_amount_less_pressed() -> void:
	SOUND_FX.button_play("back/cancel")
	unit_number -= 1
	LVL_MASTER.player_info["coins"] += unit_cost
	if unit_number == 0:
		btn_n_less.disabled = true
	label_number.text = String(unit_number)
#	signal self -> ui_army_spawner
	emit_signal('update_coins_counter')

	#Delay:
func _on_Button_delay_plus_pressed() -> void:
	SOUND_FX.button_play("acept")
	unit_delay += 1
	if unit_delay > 0:
		btn_del_less.disabled = false
	label_delay.text = String(unit_delay)

func _on_Button_delay_less_pressed() -> void:
	SOUND_FX.button_play("back/cancel")
	unit_delay -= 1
	if unit_delay == 0:
		btn_del_less.disabled = true 
	label_delay.text = String(unit_delay)
