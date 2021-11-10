extends PanelContainer

# Nodos:
onready var label_victory = get_node('VBoxContainer/Label_victory_defeat')
onready var label_score   = get_node("VBoxContainer/Label_n_score")
onready var btn_next_lvl  = get_node('VBoxContainer/HBoxContainer2/Button_next_lvl')
# Variables:
var total_score: 	int  = 0
var top_score: 		int  = 0
var score_counter: 	int  = 0
var victory_flag:	bool = false
func _ready():
	hide()

# Funciones:
func update_parameters(_total_score: int, _top_score: int, _victory_flag: bool):
	show()
	$Timer_Score.start()
	total_score 	= _total_score
	top_score		= _top_score
	victory_flag	= _victory_flag
	
	if _victory_flag:
		label_victory.text = "¡VICTORY!"
	else:
		label_victory.text = "¡DEFEAT!"
	

func _on_Timer_Score_timeout():
	if total_score > score_counter:
		score_counter += 5
		label_score.text = String(score_counter)
		if top_score * 0.8 < score_counter:
			$VBoxContainer/HBoxContainer/CheckBox_1.pressed = true
		if top_score * 0.9 < score_counter:
			$VBoxContainer/HBoxContainer/CheckBox_2.pressed = true
		if top_score == score_counter:
			$VBoxContainer/HBoxContainer/CheckBox_3.pressed = true
	else:
		$Timer_Score.stop()
		$VBoxContainer/HBoxContainer2/Button_next_lvl.disabled = !victory_flag


func _on_Button_redo_pressed():
	get_tree().reload_current_scene()
