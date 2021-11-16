extends Spatial

#Señales:
signal attack_start 	#Avisa que comenzo el ataque

#Nodos:
onready var timer_unit_1 = get_node("Timer_1")
onready var timer_unit_2 = get_node("Timer_2")
onready var timer_unit_3 = get_node("Timer_3")
onready var timer_special_unit_1 = get_node("Timer_S1")

#Escenas:
onready var UNIT = preload('res://scenes/unit.tscn')
onready var SPECIAL_UNIT = preload('res://scenes/special_unit.tscn')

#Cantidad de unidades a generar:
var unit_1: int =0
var unit_2: int =0
var unit_3: int =0
var special_unit_1: int =0

func _ready() -> void:
	pass

#Funciones:
func spawn_units(_army) -> void:
	unit_1 = _army["unit_1"]
	unit_2 = _army["unit_2"]
	unit_3 = _army["unit_3"]
	special_unit_1= _army["special_unit_1"]
	
	#Unit 1:
	if unit_1 !=0 and _army["unit_1_delay"] != 0:
		timer_unit_1.wait_time = _army["unit_1_delay"]
		timer_unit_1.start()
	elif unit_1 != 0:
		spawn_unit_1_type()
	
	#Unit 2:
	if unit_2 !=0 and _army["unit_2_delay"] != 0:
		timer_unit_2.wait_time = _army["unit_2_delay"]
		timer_unit_2.start()
	elif unit_2 != 0:
		spawn_unit_2_type()

	#Unit 3:
	if unit_3 !=0 and _army["unit_3_delay"] != 0:
		timer_unit_3.wait_time = _army["unit_3_delay"]
		timer_unit_3.start()
	elif unit_3 !=0:
		spawn_unit_3_type()
	
	if special_unit_1 !=0 and _army["special_unit_1_delay"] != 0:
		timer_special_unit_1.wait_time = _army["special_unit_1_delay"]
		timer_special_unit_1.start()
	elif special_unit_1 != 0:
		spawn_special_unit_1_type()
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

func spawn_special_unit_1_type() -> void:
	for _i in range(special_unit_1):
		get_parent().add_child(spawn(UNIT_STATS.special_unit_type_1))

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

func _on_Timer_S1_timeout() -> void:
	spawn_special_unit_1_type()
	emit_signal('attack_start')
