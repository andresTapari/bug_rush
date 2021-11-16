extends Spatial

#Señales:
signal attack_start 	#Avisa que comenzo el ataque

#Nodos:
onready var timer_unit_1 = get_node("Timer_1")
onready var timer_unit_2 = get_node("Timer_2")
onready var timer_unit_3 = get_node("Timer_3")
onready var timer_unit_4 = get_node("Timer_4")

#onready var timer_unit_n = get_node("Timer_n")

#Escenas:
onready var UNIT = preload('res://scenes/unit.tscn')
onready var SPECIAL_UNIT = preload('res://scenes/special_unit.tscn')

#Cantidad de unidades a generar:
var unit_1: 	  int =0
var unit_2: 	  int =0
var unit_3: 	  int =0
var unit_4: 	  int =0
#var unit_n: 	  int =0

var unit_1_delay: int =0
var unit_2_delay: int =0
var unit_3_delay: int =0
var unit_4_delay: int =0
#var unit_n_delay: int =0


func _ready() -> void:
	pass

#Funciones:

func spawn_units(_army_list: Array) -> void:
	for item in _army_list:
		match item["Type"]:
			UNIT_STATS.classes.unit_type_1:
				unit_1       = item["Amount"]
				unit_1_delay = item["Delay"] 
			UNIT_STATS.classes.unit_type_2:
				unit_2       = item["Amount"]
				unit_2_delay = item["Delay"] 
			UNIT_STATS.classes.unit_type_3:
				unit_3       = item["Amount"]
				unit_3_delay = item["Delay"] 
			UNIT_STATS.classes.special_unit_type_1:
				unit_4       = item["Amount"]
				unit_4_delay = item["Delay"] 

#			UNIT_STATS.classes.unit_type_n:
#				unit_n       = item["Amount"]
#				unit_n_delay = item["Delay"] 

	#Unit 1:
	if unit_1 !=0 and unit_1_delay != 0:
		timer_unit_1.wait_time = unit_1_delay
		timer_unit_1.start()
	elif unit_1 != 0:
		spawn_unit_1_type()
	
	#Unit 2:
	if unit_2 !=0 and unit_2_delay != 0:
		timer_unit_2.wait_time = unit_2_delay
		timer_unit_2.start()
	elif unit_2 != 0:
		spawn_unit_2_type()

	#Unit 3:
	if unit_3 !=0 and unit_3_delay != 0:
		timer_unit_3.wait_time = unit_3_delay
		timer_unit_3.start()
	elif unit_3 !=0:
		spawn_unit_3_type()
	
	if unit_4 !=0 and unit_4_delay != 0:
		timer_unit_4.wait_time = unit_4_delay
		timer_unit_4.start()
	elif unit_4 != 0:
		spawn_unit_4_type()
	emit_signal('attack_start')

#	#Unit n:
#	if unit_n !=0 and unit_n_delay != 0:
#		timer_unit_n.wait_time = unit_n_delay
#		timer_unit_n.start()
#	elif unit_n !=0:
#		spawn_unit_n_type()
	emit_signal('attack_start')

func spawn_unit_1_type() -> void:
	for _i in range(unit_1):
		get_parent().add_child(spawn(UNIT_STATS.unit_type_1))

func spawn_unit_2_type() -> void:
	for _i in range(unit_2):
		get_parent().add_child(spawn(UNIT_STATS.unit_type_2))

func spawn_unit_3_type() -> void:
	for _i in range(unit_3):
		get_parent().add_child(spawn(UNIT_STATS.unit_type_3))

func spawn_unit_4_type() -> void:
	for _i in range(unit_4):
		get_parent().add_child(spawn(UNIT_STATS.special_unit_type_1))
#func spawn_unit_n_type() -> void:
#	for _i in range(unit_n):
#		get_parent().add_child(spawn(UNIT_STATS.unit_type_n))


func spawn(_stats) -> Node:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var u=null
	if _stats["Name"]=="special_unit_type_1":
		u = SPECIAL_UNIT.instance()
	else:
		u = UNIT.instance()
	u.set_stats(_stats)
	u.transform = $Position3D.global_transform
	u.translation += Vector3(rng.randf_range(-2, 2),
							 0,
							 rng.randf_range(-2, 2))
	return u

# Señales:
func _on_Timer_1_timeout() -> void:
	spawn_unit_1_type()
	emit_signal('attack_start')

func _on_Timer_2_timeout() -> void:
	spawn_unit_2_type()
	emit_signal('attack_start')

func _on_Timer_3_timeout() -> void:
	spawn_unit_3_type()
	emit_signal('attack_start')

#func _on_Timer_n_timeout() -> void:
#	spawn_unit_n_type()
#	emit_signal('attack_start')

func _on_Timer_4_timeout():
	spawn_unit_4_type()
	emit_signal('attack_start')
