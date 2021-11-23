extends Spatial

func _ready() -> void:
	$CPUParticles.emitting = true

# Señales:
func _on_Timer_timeout() -> void:
	queue_free()
