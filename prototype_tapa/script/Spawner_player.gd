extends Spatial

signal attack_start

# Called when the node enters the scene tree for the first time.
onready var UNIT = preload('res://scenes/unit.tscn')

func _ready() -> void:
	$army_generator.popup()
	$army_generator.connect("spawn_units",self,"spawn_units")

func spawn_units(_army) -> void:
	var unit_triangulito = _army["triangulitos"]

	#Spawn_Triangulo
	if unit_triangulito != 0:
		for _i in range(unit_triangulito):
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
	u.translation += Vector3(rng.randi_range(-2, 2),
							 rng.randi_range(-1, 2),
							 rng.randi_range(-2, 2))
	return u
