extends StaticBody

var targets_to_attack: Array = []

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
	#apuntar a target
	#disparar municion
	pass

# Señales:
func _on_zona_de_deteccion_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		targets_to_attack.push_back(body)

func _on_zona_de_deteccion_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		targets_to_attack.erase(body)
