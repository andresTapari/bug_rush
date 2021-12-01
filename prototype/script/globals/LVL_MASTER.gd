extends Node

# Info de player:
enum difficulty {EASY,
				NORMAL,
				HARD
				}
var coin_factor_table = {
				"easy": 0.5,
				"normal": 0.15,
				"hard": 0.1
}
var player_info = {
				"score":0,
				"coins":10,
				"current_lvl_index":1,
				"coin_factor": coin_factor_table["normal"],
				"difficulty": difficulty.NORMAL,
				"victory_flag": false
}

var player_default_stats: Dictionary
# Info de lvl's:
var lvl_1_info ={
				"score": 0,
				"coins": 0,
				"icon_path": "res://assets/thumbnail/lvl_1_thumbnail.png",
				"stars": 0,
				"lvl_unloqued":true
}

var lvl_2_info ={
				"score": 0,
				"coins": 0,
				"icon_path": "res://assets/thumbnail/lvl_2_thumbnail.png",
				"stars": 0,
				"lvl_unloqued":false
}

var lvl_3_info ={
				"score": 0,
				"coins": 0,
				"icon_path": "res://assets/thumbnail/lvl_3_thumbnail.png",
				"stars": 0,
				"lvl_unloqued":false
}
var lvl_4_info ={
				"score": 0,
				"coins": 0,
				"icon_path": "res://assets/thumbnail/lvl_4_thumbnail.png",
				"stars": 0,
				"lvl_unloqued":false
}
var lvl_5_info ={
				"score": 0,
				"coins": 0,
				"icon_path": "res://assets/thumbnail/lvl_5_thumbnail.png",
				"stars": 0,
				"lvl_unloqued":false
}
var lvl_6_info ={
				"score": 0,
				"coins": 0,
				"icon_path": "res://assets/thumbnail/lvl_6_thumbnail.png",
				"stars": 0,
				"lvl_unloqued":false
}
func _ready() -> void:
	player_default_stats = player_info.duplicate()

# Funciones:
func lvl_path(_current_lvl_index: int) -> String:
	match _current_lvl_index:
		1:
			return "res://lvls/lvl_1.tscn"
		2: 
			return "res://lvls/lvl_2.tscn"
		3: 
			return "res://lvls/lvl_3.tscn"
		4: 
			return "res://lvls/lvl_4.tscn"
		5: 
			return "res://lvls/lvl_5.tscn"
		6: 
			return "res://lvls/lvl_6.tscn"
		7: 
			return "res://lvls/end_menu.tscn"
	return ""

func lvl_info(_index:int) ->  Dictionary:
	match _index:
		1:
			return lvl_1_info
		2:
			return lvl_2_info
		3:
			return lvl_3_info
		4:
			return lvl_4_info
		5:
			return lvl_5_info
		6:
			return lvl_6_info
	return Dictionary() #null

func clear_all_stats()->void:
	var list_of_lvls:Array = [lvl_1_info,lvl_2_info,lvl_3_info,
							  lvl_4_info,lvl_5_info,lvl_6_info]
	for element in list_of_lvls:
		element["score"] = 0
		element["coins"] = 0
		element["stars"] = 0
		element["lvl_unloqued"] = false
	lvl_1_info["lvl_unloqued"]  = true
	player_info = player_default_stats.duplicate(true)

func get_total_score() -> int:
	var total_score: int = 0
	var list_of_lvls:Array = [lvl_1_info,lvl_2_info,lvl_3_info,
							  lvl_4_info,lvl_5_info,lvl_6_info]
	for element in list_of_lvls:
		total_score += element["score"]
	return total_score
