extends Spatial

# Nodos:
onready var lvl_progress = get_node('ui_hud/VBoxContainer/TextureProgress')

# Variables
var player_units: 		Array = []
var enemy_units: 		Array = []

var enemy_deleted: 		int   = 0
var enemy_units_total:  int   = 0
var victory_condition:  int   = 1

var lvl_score: 			int = 0
var lvl_top_score: 		int = 0

func _ready() -> void:
	# Señal de ui_hud al lvl
	# warning-ignore:return_value_discarded
	$ui_hud.connect("stop_round",self,"stop_round")

	# Señal del army generator hacia el spawner
	# warning-ignore:return_value_discarded
	$ui_hud/army_generator.connect("spawn_units",$Spawner,"spawn_units")
	
	# Señal del spawner al lvl
	# warning-ignore:return_value_discarded
	$Spawner.connect("attack_start",self,"set_targets")
	 
	
	# Determinamos cantidad de enemigos por nivel
	var nodos:Array = get_children() 
	var enemy_counter: float = 0
	for element in nodos:
		if element.is_in_group("enemy"):
			enemy_units.push_front(element)
			enemy_counter += 1 
	#warning-ignore:narrowing_conversion
	victory_condition = enemy_counter * (0.2) # 20% de unidades restantes
	if victory_condition == 0:
		victory_condition = 1
	enemy_units_total =  enemy_units.size()

func set_targets()-> void:
	var nodos:Array = get_children() 
	player_units.clear()
	enemy_units.clear()
	for element in nodos:
		if element.is_in_group("player"):
			player_units.push_front(element)
			element.connect("player_unit_destroyed",self,"handle_destroy_unit")
		if element.is_in_group("enemy"):
			lvl_top_score += element.score
			enemy_units.push_front(element)
			element.connect("enemy_unit_destroyed",self,"handle_destroy_enemy")
	for element in player_units:
		element.set_targets_to_attack(enemy_units.duplicate(true))
	
		
func handle_destroy_enemy(_enemy_unit_name):
	lvl_score += _enemy_unit_name.score
	enemy_units.erase(_enemy_unit_name)
	enemy_deleted += 1
	lvl_progress.update_bar(enemy_deleted,enemy_units_total)
	for element in player_units:
		element.timer.stop()
		if is_instance_valid(element):
			element.set_targets_to_attack(enemy_units)
	if enemy_units.size() == 0:
		$ui_hud/ui_score_dialog.update_parameters(lvl_score,lvl_top_score,true)

func handle_destroy_unit(_player_unit_name):
	player_units.erase(_player_unit_name)
	if player_units.size() == 0:
		if enemy_units.size() <= victory_condition:
			$ui_hud/ui_score_dialog.update_parameters(lvl_score,
														lvl_top_score,true)
		else:
			$ui_hud/ui_score_dialog.update_parameters(lvl_score,
														lvl_top_score,false)
func stop_round():
	if enemy_units.size() <= victory_condition:
		$ui_hud/ui_score_dialog.update_parameters(lvl_score,
													lvl_top_score,true)
	else:
		$ui_hud/ui_score_dialog.update_parameters(lvl_score,
													lvl_top_score,false)
