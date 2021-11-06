extends Spatial

var player_units: Array = []
var enemy_units: Array 	= []

func _ready() -> void:
	$Spawner.connect("attack_start",self,"set_targets")
	
func set_targets()-> void:
	var nodos:Array = get_children() 
	player_units.clear()
	enemy_units.clear()
	for element in nodos:
		if element.is_in_group("player"):
			player_units.push_front(element)

		if element.is_in_group("enemy"):
			enemy_units.push_front(element)
			element.connect("tower_destroyed",self,"handle_destroy_enemy")

	for element in player_units:
		element.set_targets_to_attack(enemy_units.duplicate(true))
	
func handle_destroy_enemy(_enemy_unit_name):
	enemy_units.erase(_enemy_unit_name)
	for element in player_units:
		if is_instance_valid(element):
			element.set_targets_to_attack(enemy_units)
