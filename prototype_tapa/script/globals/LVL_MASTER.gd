extends Node

# Info de player:
var player_info = {
				"score":0,
				"coins":10,

}

# Info de lvl's:
var lvl_1_info ={
				"score": 0,
				"coins": 0,
				"icon_path": "",
				"stars": 0,
				"lvl_unloqued":true
}

var lvl_2_info ={
				"score": 0,
				"coins": 0,
				"icon_path": "",
				"stars": 0,
				"lvl_unloqued":false
}

var lvl_3_info ={
				"score": 0,
				"coins": 0,
				"icon_path": "",
				"stars": 0,
				"lvl_unloqued":false
}
var lvl_4_info ={
				"score": 0,
				"coins": 0,
				"icon_path": "",
				"stars": 0,
				"lvl_unloqued":false
}
var lvl_5_info ={
				"score": 0,
				"coins": 0,
				"icon_path": "",
				"stars": 0,
				"lvl_unloqued":false
}
var lvl_6_info ={
				"score": 0,
				"coins": 0,
				"icon_path": "",
				"stars": 0,
				"lvl_unloqued":false
}

# Funciones:
func lvl_path(_current_lvl_index: int) -> String:
	match _current_lvl_index:
		1:
			return "res://lvls/dev_lvl_1.tscn"
		2: 
			return "res://lvls/dev_lvl_2.tscn"
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

