extends PopupDialog

# Nodos:
onready var label_victory = get_node('VBoxContainer/Label_victory_defeat')
onready var label_score   = get_node("VBoxContainer/HBoxContainer3/Label_n_score")
onready var label_coin    = get_node('VBoxContainer/HBoxContainer4/Label_n_coins')
onready var btn_next_lvl  = get_node('VBoxContainer/HBoxContainer2/Button_next_lvl')

# Variables:
var total_score: 	int     = 0
var top_score: 		int     = 0
var score_counter: 	int     = 0
var coins_counter:	float   = 0.0
var victory_flag:	bool    = false
var stars_counter:  int     = 0
var top_coin:		float	= 0.0
var score_star:		int     = 0

func _ready():
	hide()

# Funciones:
func update_parameters(_total_score: int, _top_score: int, _victory_flag: bool) -> void:
	show()
	score_counter = _total_score
	label_score.text = String(score_counter)
	$Timer_Score.start()
	total_score 	= _total_score
	top_score		= _top_score
	victory_flag	= _victory_flag
	top_coin		= float(_total_score)*LVL_MASTER.player_info["coin_factor"]

	if _victory_flag:
		label_victory.bbcode_text = "[center][color=#3FFF33]VICTORY![/color][/center]"
	else:
		label_victory.bbcode_text = "[center][color=red]DEFEAT[/color][/center]"

func update_player_info()-> void:
	var index = LVL_MASTER.player_info["current_lvl"]
	match index:
		1:
			LVL_MASTER.lvl_1_info["score"] = total_score
			LVL_MASTER.lvl_1_info["coins"] = coins_counter
			LVL_MASTER.lvl_1_info["stars"] = stars_counter
		2:
			LVL_MASTER.lvl_2_info["score"] = total_score
			LVL_MASTER.lvl_2_info["coins"] = coins_counter
			LVL_MASTER.lvl_2_info["stars"] = stars_counter
		3:
			LVL_MASTER.lvl_3_info["score"] = total_score
			LVL_MASTER.lvl_3_info["coins"] = coins_counter
			LVL_MASTER.lvl_3_info["stars"] = stars_counter
		4:
			LVL_MASTER.lvl_4_info["score"] = total_score
			LVL_MASTER.lvl_4_info["coins"] = coins_counter
			LVL_MASTER.lvl_4_info["stars"] = stars_counter
		5:
			LVL_MASTER.lvl_5_info["score"] = total_score
			LVL_MASTER.lvl_5_info["coins"] = coins_counter
			LVL_MASTER.lvl_5_info["stars"] = stars_counter
		6:
			LVL_MASTER.lvl_6_info["score"] = total_score
			LVL_MASTER.lvl_6_info["coins"] = coins_counter
			LVL_MASTER.lvl_6_info["stars"] = stars_counter
	
	if victory_flag:
		LVL_MASTER.lvl_info(index+1)["lvl_unloqued"]=true
		LVL_MASTER.player_info["score"] += score_counter
		LVL_MASTER.player_info["coins"] += coins_counter
	
func _on_Timer_Score_timeout():
	if 0 < score_counter:
		score_star +=5
		score_counter -= 5
		coins_counter += LVL_MASTER.player_info["coin_factor"]*5
		label_score.text = String(score_counter)
		label_coin.text  = String(int(coins_counter))
		if top_score * 0.8 < score_star:
			$VBoxContainer/HBoxContainer/CheckBox_1.pressed = true
			stars_counter += 1
		if top_score * 0.9 < score_star:
			$VBoxContainer/HBoxContainer/CheckBox_2.pressed = true
			stars_counter += 1
		if top_score == score_star:
			$VBoxContainer/HBoxContainer/CheckBox_3.pressed = true
			stars_counter += 1
	else:
		$Timer_Score.stop()
		update_player_info()
		$VBoxContainer/HBoxContainer2/Button_next_lvl.disabled = !victory_flag
		get_tree().paused = true

func _on_Button_redo_pressed():
	SOUND_FX.button_play("back/cancel")
	if victory_flag:
		LVL_MASTER.player_info["current_lvl"] -= 1
	get_tree().paused = false
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func _on_Button_lvl_selection_pressed() -> void:
	SOUND_FX.button_play("acept")
	get_tree().paused = false
	var lvl_selection = "res://lvls/lvl_selection.tscn"
	# warning-ignore:return_value_discarded
	get_tree().change_scene(lvl_selection)

func _on_Buton_main_menu_pressed() -> void:
	SOUND_FX.button_play("back/cancel")
	get_tree().paused = false
	var lvl_selection = "res://lvls/main_menu.tscn"
	# warning-ignore:return_value_discarded
	get_tree().change_scene(lvl_selection)


func _on_Button_next_lvl_pressed() -> void:
	var lvl_selection: String
	SOUND_FX.button_play("acept")
	get_tree().paused = false
	if get_parent().current_lvl == LVL_MASTER.player_info["current_lvl_index"]:
		if LVL_MASTER.player_info["current_lvl_index"] <= 6:
			LVL_MASTER.player_info["current_lvl_index"] +=1
			lvl_selection = LVL_MASTER.lvl_path(LVL_MASTER.player_info["current_lvl_index"])
		if LVL_MASTER.player_info["current_lvl_index"] == 7:
			LVL_MASTER.player_info["victory_flag"] = true
	else:
			lvl_selection = LVL_MASTER.lvl_path(get_parent().current_lvl + 1)
	# warning-ignore:return_value_discarded
	get_tree().change_scene(lvl_selection)

func _on_PopupDialog_about_to_show():
	pass

func _on_PopupDialog_popup_hide():
	get_tree().paused = false
