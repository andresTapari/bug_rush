extends StaticBody

# Señales:
signal enemy_unit_destroyed(value)

# Variables
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

# Nodos:
onready var draw   		= get_node('Muzzle/Draw')
onready var muzzle 		= get_node('Muzzle')
onready var gun			= get_node('Muzzle/gun')
onready var HealthBarr 	= get_node('HealthBarr3D/Viewport/HealthBarr2D')

# Escenas:
onready var BULLET = preload('res://scenes/bullet.tscn')
onready var HIT_COUNTER = preload('res://scenes/hit_counter_3D.tscn')
onready var SCORE_COUNTER = preload('res://scenes/score_counter_3D.tscn')
onready var SMOKE = preload('res://scenes/shoot_smoke.tscn')
onready var EXPLOSION = preload('res://scenes/unit_explosion.tscn')

func _ready() -> void:
	type 			= UNIT_STATS.enemy_type_2["Type"]
	u_name	 		= UNIT_STATS.enemy_type_2["Name"]
	total_health 	= UNIT_STATS.enemy_type_2["Health"]
	damage 			= UNIT_STATS.enemy_type_2["Damage"]
	fire_rate 		= UNIT_STATS.enemy_type_2["FR"]
	armor 			= UNIT_STATS.enemy_type_2["Armor"]
	score 			= UNIT_STATS.enemy_type_2["Score"]
	actual_health = total_health
	$Timer.wait_time = fire_rate
	
func _process(_delta: float) -> void:
	if !targets_to_attack.empty():
		if !is_instance_valid(targets_to_attack[0]):
			targets_to_attack.remove(0)
		var target = targets_to_attack[0]
		attack_target(target)

# Funciones:
func attack_target(_target:Node) -> void:
	muzzle.look_at(_target.translation,Vector3.UP)
#	draw_aim(_target)
	shoot()

func draw_aim(_target:Node)->void:
	var dist =  (_target.translation - muzzle.transform.origin).length()
	draw.clear()
	draw.begin(Mesh.PRIMITIVE_LINE_STRIP)
	draw.add_vertex(Vector3())
	draw.add_vertex(Vector3(0,0,-dist)) #_target.translation
	draw.end()

func shoot() -> void:
	if weapon_enable:
		weapon_enable = false
		var b = BULLET.instance()
		b.damage = damage
		b.transform = gun.global_transform
		b.velocity = -b.transform.basis.z * -b.muzzle_velocity
		get_parent().add_child(b)
		get_node("Timer").start()

#		var h = SMOKE.instance()
#		h.transform = gun.global_transform
#		get_parent().add_child(h)

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
		var S = SCORE_COUNTER.instance()
		S.set_score(score)
		S.transform = self.global_transform
		get_parent().add_child(S)
		emit_signal("enemy_unit_destroyed",self)
		queue_free()

# Señales:
func _on_zona_de_deteccion_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		targets_to_attack.push_back(body)

func _on_zona_de_deteccion_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		targets_to_attack.erase(body)

func _on_Timer_timeout() -> void:
	weapon_enable = true
