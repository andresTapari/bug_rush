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

#Nodos:
onready var HealthBarr = get_node('HealthBarr3D/Viewport/HealthBarr2D')

func _ready() -> void:
	type = UNIT_STATS.enemy_type_1["Type"]
	u_name = UNIT_STATS.enemy_type_1["Name"]
	total_health = UNIT_STATS.enemy_type_1["Health"]
	damage = UNIT_STATS.enemy_type_1["Damage"]
	fire_rate = UNIT_STATS.enemy_type_1["FR"]
	armor = UNIT_STATS.enemy_type_1["Armor"]
	actual_health = total_health
	
#Funciones
func hurt(_damage: float) -> void:
	actual_health = actual_health - _damage
	HealthBarr.update_bar(actual_health,total_health)
	if actual_health <= 0:
		emit_signal("enemy_unit_destroyed",self)
		queue_free()
