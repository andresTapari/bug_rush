extends StaticBody
#Señales:
signal enemy_unit_destroyed(value)

#Variables:
var type
var u_name: String
var total_health :float
var actual_health = total_health
var damage : float
var fire_rate : float
var armor : float
var score: int

#Nodos:
onready var HealthBarr = get_node('HealthBarr3D/Viewport/HealthBarr2D')
onready var HIT_COUNTER = preload('res://scenes/hit_counter_3D.tscn')
onready var EXPLOSION = preload('res://scenes/unit_explosion.tscn')

func _ready() -> void:
	type 			= UNIT_STATS.enemy_type_1["Type"]
	u_name	 		= UNIT_STATS.enemy_type_1["Name"]
	total_health 	= UNIT_STATS.enemy_type_1["Health"]
	damage 			= UNIT_STATS.enemy_type_1["Damage"]
	fire_rate 		= UNIT_STATS.enemy_type_1["FR"]
	armor 			= UNIT_STATS.enemy_type_1["Armor"]
	score 			= UNIT_STATS.enemy_type_1["Score"]
	actual_health = total_health
	
#Funciones
func hurt(_damage: float) -> void:
	actual_health = actual_health - _damage
	HealthBarr.update_bar(actual_health,total_health)
	var h = HIT_COUNTER.instance()
	h.set_damage(_damage)
	h.transform = self.global_transform
	get_parent().add_child(h)
	if actual_health <= 0:
		emit_signal("enemy_unit_destroyed",self)
		var E = EXPLOSION.instance()
		E.set_type(false)
		E.transform = self.global_transform
		get_parent().add_child(E)
		queue_free()
