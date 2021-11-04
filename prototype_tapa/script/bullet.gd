extends Area

export var muzzle_velocity = 50
var target: Node = null

export var damage: float = 3

var velocity = Vector3.ZERO

func _ready() -> void:
	$Timer.start()

func _physics_process(delta):
	transform.origin -= velocity * delta

func _on_Timer_timeout() -> void:
	queue_free()

func _on_bullet_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.hurt(damage)
		queue_free()

func _on_VisibilityNotifier_screen_exited() -> void:
	queue_free()
