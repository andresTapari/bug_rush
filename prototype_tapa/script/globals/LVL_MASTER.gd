extends Node

# Info de player:
var player_info = {
				"current_lvl": 1,
				"score":0,
				"coins":0,
}

# Info de lvl_1:
var lvl_1_info ={
				"score": 0,
				"coins": 0,
				"icon_path": "",
				"stars": 0
}

# Funciones:
func lvl_path(_value: int) -> String:
	match _value:
		1:
			return "res://lvls/dev_lvl_1.tscn"
		2: 
			return "res://lvls/dev_lvl_2.tscn"
	return ""
