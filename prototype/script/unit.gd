extends KinematicBody

export var speed = 5
export var gravity = -5

export var velocity = Vector3.ZERO
export var target_to_move: NodePath

export var total_health = 10

onready var HealthBarr = get_node('HealthBarr3D/Viewport/HealthBarr2D')

var target = null
var actual_health = total_health

func _ready() -> void:
	if target_to_move !=  null:
		target = get_node(target_to_move).translation

func _physics_process(delta):
	velocity.y += gravity * delta
	if target:
		look_at(target, Vector3.UP)
		rotation.x = 0
		velocity = -transform.basis.z * speed
		if transform.origin.distance_to(target) < 1.5:
			target = null
			velocity = Vector3.ZERO
	velocity = move_and_slide(velocity, Vector3.UP)

# Funciones:

func hurt(_damage: float) -> void:
	actual_health = actual_health - _damage
	HealthBarr.update_bar(actual_health,total_health)
	if actual_health <= 0:
		queue_free()
