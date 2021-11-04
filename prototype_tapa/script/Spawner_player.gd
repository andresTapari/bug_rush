extends Spatial


signal attack_start

# Called when the node enters the scene tree for the first time.
onready var UNIT = preload('res://scenes/unit.tscn')

func _ready() -> void:
	$army_generator.popup()
	$army_generator.connect("spawn_units",self,"spawn_units")

func spawn_units(_army):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var unit_triangulito = _army["triangulitos"]
	for i in range(unit_triangulito):
		var u = UNIT.instance()
		u.transform = $Position3D.global_transform
		u.translation += Vector3(rng.randi_range(-2, 2),rng.randi_range(-1, 2),rng.randi_range(-2, 2))
		get_parent().add_child(u)
	emit_signal('attack_start')
