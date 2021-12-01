extends Spatial

func _ready() -> void:
	$CPUParticles.emitting = true

func set_type(unit_player: bool = true)-> void:
	if unit_player:
		$AudioStreamPlayer.stream = load("res://assets/sounds/unit_self_explosion.wav")
	else:
		$AudioStreamPlayer.stream = load("res://assets/sounds/enemy_self_explosion.wav")
	$AudioStreamPlayer.play()

# Señales:
func _on_Timer_timeout() -> void:
	queue_free()
