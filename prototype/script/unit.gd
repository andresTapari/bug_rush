extends KinematicBody

export var speed = 10
export var gravity = -5


export var velocity = Vector3.ZERO
export var target_to_move: NodePath

var target = null

func _ready() -> void:
	if target_to_move:
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
