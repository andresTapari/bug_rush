tool
extends StaticBody

var targets_to_attack: Array = []
var weapon_enable: bool = true


export var total_health = 10
var actual_health = total_health

onready var draw   = get_node('Muzzle/Draw')
onready var muzzle = get_node('Muzzle')
onready var HealthBarr = get_node('HealthBarr3D/Viewport/HealthBarr2D')

onready var BULLET = preload('res://scenes/bullet.tscn')

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if !targets_to_attack.empty():
		if !is_instance_valid(targets_to_attack[0]):
			targets_to_attack.remove(0)
		var target = targets_to_attack[0]
		attack_target(target)

# Funciones:
func attack_target(_target:Node) -> void:
	muzzle.look_at(_target.translation,Vector3.UP)
	draw_aim(_target)
	shoot()

func draw_aim(_target:Node)->void:
	var dist =  (_target.translation - muzzle.transform.origin).length()
	draw.clear()
	draw.begin(Mesh.PRIMITIVE_LINE_STRIP)
	draw.add_vertex(Vector3())
	draw.add_vertex(Vector3(0,0,-dist)) #_target.translation
	draw.end()

func shoot():
	if weapon_enable:
		weapon_enable = false
		var b = BULLET.instance()
		b.transform = get_node("Muzzle").global_transform
		b.velocity = -b.transform.basis.z * -b.muzzle_velocity
		get_parent().add_child(b)
		get_node("Timer").start()

func hurt(_damage: float) -> void:
	actual_health = actual_health - _damage
	HealthBarr.update_bar(actual_health,total_health)
	if actual_health <= 0:
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
