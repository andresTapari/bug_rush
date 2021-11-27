extends StaticBody

# Nodos:
onready var HealthBarr 	= get_node('HealthBarr3D/Viewport/HealthBarr2D')

# Escenas:
onready var HIT_COUNTER = preload('res://scenes/hit_counter_3D.tscn')
onready var EXPLOSION = preload('res://scenes/unit_explosion.tscn')

# Señales:
signal enemy_unit_destroyed

# Variables:
var type
var u_name: String
var total_health :float
var actual_health = total_health
var damage : float
var fire_rate : float
var armor : float
var score: int
var targets_to_attack: Array = []
var weapon_enable: bool = true


func _ready() -> void:
	type 			= UNIT_STATS.enemy_type_4["Type"]
	u_name	 		= UNIT_STATS.enemy_type_4["Name"]
	total_health 	= UNIT_STATS.enemy_type_4["Health"]
	damage 			= UNIT_STATS.enemy_type_4["Damage"]
	fire_rate 		= UNIT_STATS.enemy_type_4["FR"]
	armor 			= UNIT_STATS.enemy_type_4["Armor"]
	score 			= UNIT_STATS.enemy_type_4["Score"]
	actual_health = total_health
	$Timer.wait_time = fire_rate

# Funciones:
func hurt(_damage: float) -> void:
	actual_health = actual_health - _damage
	HealthBarr.update_bar(actual_health,total_health)
	var h = HIT_COUNTER.instance()
	h.set_damage(_damage)
	h.transform = self.global_transform
	get_parent().add_child(h)
	if actual_health <= 0:
		var E = EXPLOSION.instance()
		E.set_type(false)
		E.transform = self.global_transform
		get_parent().add_child(E)
		emit_signal("enemy_unit_destroyed",self)
		queue_free()

# Señales
func _on_Area_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		targets_to_attack.push_front(body)
		if $Timer.is_stopped():
			$Timer.start()

func _on_Timer_timeout() -> void:
	for element in targets_to_attack:
		if is_instance_valid(element):
			element.hurt(damage)
		else:
			targets_to_attack.erase(element)

func _on_Area_body_exited(body: Node) -> void:
	pass # Replace with function body.
