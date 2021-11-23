extends StaticBody

# Señales:
signal enemy_unit_destroyed(value)

# Nodos:
onready var HealthBarr 	= get_node('HealthBarr3D/Viewport/HealthBarr2D')

# Escenas:
onready var HIT_COUNTER = preload('res://scenes/hit_counter_3D.tscn')

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
	type 			= UNIT_STATS.enemy_type_3["Type"]
	u_name	 		= UNIT_STATS.enemy_type_3["Name"]
	total_health 	= UNIT_STATS.enemy_type_3["Health"]
	damage 			= UNIT_STATS.enemy_type_3["Damage"]
	fire_rate 		= UNIT_STATS.enemy_type_3["FR"]
	armor 			= UNIT_STATS.enemy_type_3["Armor"]
	score 			= UNIT_STATS.enemy_type_3["Score"]
	actual_health = total_health
	$Timer.wait_time = fire_rate

#func _process(delta: float) -> void:
#	if !targets_to_attack.empty() and $Timer.is_stopped():
#		$Position3D/CPUParticles.emitting = true
#		$Timer.start()
#	elif targets_to_attack.empty():
#		$Position3D/CPUParticles.emitting = false
#		$Timer.stop()

func hurt(_damage: float) -> void:
	actual_health = actual_health - _damage
	HealthBarr.update_bar(actual_health,total_health)
	var h = HIT_COUNTER.instance()
	h.set_damage(_damage)
	h.transform = self.global_transform
	get_parent().add_child(h)
	if actual_health <= 0:
		emit_signal("enemy_unit_destroyed",self)
		queue_free()
 
# Señales:
func _on_Timer_timeout() -> void:
	for element in targets_to_attack:
		if is_instance_valid(element):
			element.hurt(damage)
		else:
			targets_to_attack.erase(element)

func _on_zona_de_deteccion_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		targets_to_attack.push_front(body)
		if $Timer.is_stopped():
			$Position3D/CPUParticles.emitting = true
			$Timer.start()

func _on_zona_de_deteccion_body_exited(_body: Node) -> void:
	if targets_to_attack.empty():
		$Position3D/CPUParticles.emitting = false
		$Timer.stop()
