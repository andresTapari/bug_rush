extends Spatial

var vel = 5

func _ready() -> void:
	pass
#	$Viewport/hit_counter_2D/Label.visible = true

func _process(_delta) -> void:
	transform.origin += vel * Vector3(0,1,0) * _delta

# Funciones
func set_damage(_value: int) -> void:
	$Viewport/hit_counter_2D/Label.text = String(_value)

func _on_Timer_timeout() -> void:
	queue_free()
#	pass
	
