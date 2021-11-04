extends KinematicBody

onready var HealthBarr = get_node('HealthBarr3D/Viewport/HealthBarr2D')
onready var ray_cast = get_node('RayCast')

export var speed: float	 	    = 5
export var gravity: float 	    = -5
export var velocity: Vector3    = Vector3.ZERO
export var total_health: float  = 10
export var target_to_move: NodePath
export var damage: float = 3

var targets_to_attack:Array = [] setget set_targets_to_attack
var ready_to_hit: bool = true

var mineral_pos= null
var Queen_pos=null
var target = null
var actual_health = total_health

func _ready() -> void:
	pass
#	if target_to_move !=  null:
#		target = get_node(target_to_move).translation

func _physics_process(delta):
	var target_pos: Vector3 = Vector3()
	if !targets_to_attack.empty():
		target = targets_to_attack[0]
		if !is_instance_valid(target):
			targets_to_attack.remove(0)
			target_pos = self.translation
		else:
			target_pos = target.translation
	velocity.y += gravity * delta
	if target and self.is_on_floor():
		look_at(target_pos, Vector3.UP)
		rotation.x = 0
		velocity = -transform.basis.z * speed
		if transform.origin.distance_to(target_pos) < 1.5:
			target = null
			velocity = Vector3.ZERO

	#Si puede atacar
	if ray_cast.is_colliding():
		var temp = ray_cast.get_collider()
		if ready_to_hit and temp.is_in_group("enemy"):
			temp.hurt(damage)
			ready_to_hit = false
			$Timer.start()
	velocity = move_and_slide(velocity, Vector3.UP)

# Funciones:

func hurt(_damage: float) -> void:
	actual_health = actual_health - _damage
	HealthBarr.update_bar(actual_health,total_health)
	if actual_health <= 0:
		queue_free()

# Funciones set&get:
func set_targets_to_attack(_value: Array):
	targets_to_attack = _value

func _on_Timer_timeout() -> void:
	ready_to_hit = true
