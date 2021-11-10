extends Spatial

onready var HIT_COUNTER = preload('res://scenes/hit_counter_3D.tscn')

func _on_Timer_timeout() -> void:
	var h = HIT_COUNTER.instance()
	h.set_damage(20)
	h.transform = self.global_transform
	add_child(h)
