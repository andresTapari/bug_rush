extends CanvasLayer

signal stop_round

# nodos:
onready var lvl_progress_barr = get_node('VBoxContainer/TextureProgress')
onready var btn_prepare 	  = get_node('VBoxContainer/btn_preparar_ataque')
onready var army_generator	  = get_node('army_generator')
#onready var score_dialog	  = get_node("ui_score_dialog")

var player_state: String = "preparar"
# variables:
var enemigos: float = 0

func _ready() -> void:
	army_generator.connect('attack_started',self,"handle_attack_started")
	lvl_progress_barr.value = 0

# señales:
func _on_Button_pressed() -> void:
	pass


func _on_btn_preparar_ataque_pressed() -> void:
	if player_state == "preparar":
		army_generator.popup()
	elif player_state == "atacando":
		emit_signal("stop_round")
		pass

func handle_attack_started():
	btn_prepare.text = "Terminar Ataque"
	player_state = "atacando"
	
