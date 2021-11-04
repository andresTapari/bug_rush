extends Spatial

var player_units: Array = []
var enemy_units: Array 	= []

func _ready() -> void:
	$Spawner.connect("attack_start",self,"set_targets")
	
func set_targets()-> void:
	var nodos:Array = get_children() 
	for element in nodos:
		if element.is_in_group("player"):
			player_units.push_front(element)
		if element.is_in_group("enemy"):
			enemy_units.push_front(element)
	for element in player_units:
		element.set_targets_to_attack(enemy_units)
	
