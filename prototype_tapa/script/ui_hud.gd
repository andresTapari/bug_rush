extends CanvasLayer

signal stop_round

# nodos:
onready var lvl_progress_barr = get_node('VBoxContainer/TextureProgress')
onready var btn_prepare 	  = get_node('VBoxContainer/btn_preparar_ataque')
onready var army_generator	  = get_node('ui_army_spawner')
onready var lvl_counter		  = get_node('MarginContainer/VBoxContainer/HBoxContainer2/Label_lvl_counter')
onready var coins		  	  = get_node('MarginContainer/VBoxContainer/HBoxContainer/Label_coint_counter')
#onready var score_dialog	  = get_node("ui_score_dialog")

var player_state: String = "preparar"
# variables:
var enemigos: float = 0

func _ready() -> void:
	army_generator.connect('attack_started',self,"handle_attack_started")
	lvl_progress_barr.value = 0
	lvl_counter.text = String(get_parent().index_lvl)
	coins.text=String(LVL_MASTER.player_info["coins"])
func _input(event):
	if  event is InputEventKey and Input.is_action_pressed("pause"):
		print(event)
		$ui_pause_dialog.popup()

# señales:
func _on_Button_pressed() -> void:
	pass


func _on_btn_preparar_ataque_pressed() -> void:
	SOUND_FX.button_play("acept")
	if player_state == "preparar":
		army_generator.popup()
	elif player_state == "atacando":
		emit_signal("stop_round")
		pass

func handle_attack_started():
	btn_prepare.text = "Stop Atack"
	player_state = "atacando"

func _on_ui_pause_dialog_popup_hide():
	get_tree().paused = false

func _on_ui_pause_dialog_about_to_show():
	get_tree().paused = true

func _on_ui_score_dialog_visibility_changed():
	get_tree().paused = !get_tree().paused
