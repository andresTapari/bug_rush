extends Spatial

signal attack_start

# Called when the node enters the scene tree for the first time.
onready var UNIT = preload('res://scenes/unit.tscn')
onready var ui_army_generator = get_node('army_generator')
export var gold: int = 10

var unit_counter_1: int = 0
var unit_counter_2: int = 0
var unit_counter_3: int = 0

func _ready() -> void:
	$army_generator.popup()
	$army_generator.connect("spawn_units",self,"spawn_units")
	ui_army_generator.set_gold(gold)

func spawn_units(_army) -> void:
	unit_counter_1 = _army["triangulitos"]
	#Spawn_Triangulo
	if unit_counter_1 != 0 and _army["delay_unit_1"] != 0:
		$Timer_unit_1.wait_time = _army["delay_unit_1"]
		$Timer_unit_1.start()
	elif unit_counter_1 != 0:
		for _i in range(unit_counter_1):
			get_parent().add_child(spawn(UNIT_STATS.triangulo))

	#Spawn_Cubo
	var unit_cubito = _army["cubitos"]
	if unit_cubito != 0:
		for _i in range(unit_cubito):
			get_parent().add_child(spawn(UNIT_STATS.cubo))

	#Spawn_Esfera
	var unit_esferita = _army["esferitas"]
	if unit_esferita != 0:
		for _i in range(unit_esferita):
			get_parent().add_child(spawn(UNIT_STATS.esfera))
	emit_signal('attack_start')

func spawn(_stats) -> Node:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var u = UNIT.instance()
	u.set_stats(_stats)
	u.transform = $Position3D.global_transform
	u.translation += Vector3(rng.randi_range(-3, 3),
							 rng.randi_range(-3, 3),
							 rng.randi_range(-3, 3))
	return u


func _on_Timer_unit_1_timeout() -> void:
	for _i in range(unit_counter_1):
		get_parent().add_child(spawn(UNIT_STATS.triangulo))
	emit_signal('attack_start')

func _on_Timer_unit_2_timeout() -> void:
	pass # Replace with function body.


func _on_Timer_unit_3_timeout() -> void:
	pass # Replace with function body.
