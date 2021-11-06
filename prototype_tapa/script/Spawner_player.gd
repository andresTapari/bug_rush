extends Spatial

#Señales:
signal attack_start 	#Avisa que comenzo el ataque

#Nodos:
onready var timer_unit_1 = get_node("Timer_1")
onready var timer_unit_2 = get_node("Timer_2")
onready var timer_unit_3 = get_node("Timer_3")

#Cantidad de unidades a genera:
var unit_1: int =0
var unit_2: int =0
var unit_3: int =0

# Called when the node enters the scene tree for the first time.
onready var UNIT = preload('res://scenes/unit.tscn')

func _ready() -> void:
	$army_generator.popup()
	$army_generator.connect("spawn_units",self,"spawn_units")

func spawn_units(_army) -> void:
	unit_1 = _army["unit_1"]
	unit_2 = _army["unit_2"]
	unit_3 = _army["unit_3"]
	
	#Unit 1:
	if unit_1 !=0 and _army["unit_1_delay"] != 0:
		$TimerCirculo.wait_time = _army["unit_1_delay"]
		$TimerCirculo.start()
	elif unit_1 != 0:
		spawn_unit_1_type()
	
	#Unit 2:
	if unit_2 !=0 and _army["unit_2_delay"] != 0:
		$TimerCirculo.wait_time = _army["unit_2_delay"]
		$TimerCirculo.start()
	elif unit_1 != 0:
		spawn_unit_2_type()
		
	if unit_3 !=0:
		$TimerTriangulo.wait_time=_army["unit_3_delay"]
		$TimerTriangulo.start()


func spawn_unit_1_type() -> void:
	for _i in range(unit_2):
		get_parent().add_child(spawn(UNIT_STATS.cubo))

func spawn_unit_2_type() -> void:
	for _i in range(unit_1):
		get_parent().add_child(spawn(UNIT_STATS.triangulo))

func spawn_unit_3_type() -> void:
		for _i in range(unit_3):
			get_parent().add_child(spawn(UNIT_STATS.esfera))

func spawn(_stats) -> Node:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var u = UNIT.instance()
	u.set_stats(_stats)
	u.transform = $Position3D.global_transform
	u.translation += Vector3(rng.randi_range(-2, 2),
							 0,
							 rng.randi_range(-2, 2))
	return u

func _on_TimerTriangulo_timeout():
	spawn_unit_2_type()
	emit_signal('attack_start')

func _on_TimerCuadrado_timeout():
	spawn_unit_1_type()
	emit_signal('attack_start')

func _on_TimerCirculo_timeout():
	spawn_unit_3_type()
	emit_signal('attack_start')
