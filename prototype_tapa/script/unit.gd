#tool
extends KinematicBody

onready var HealthBarr 	= get_node('HealthBarr3D/Viewport/HealthBarr2D')
onready var ray_cast 	= get_node('RayCast')

export var speed: float	 	    	= 5
export var gravity: float 	    	= -5
export var total_health: float  	= 10
export var damage: float 			= 3
export var armor: float				= 5
export (UNIT_STATS.classes) var clase

var target_to_move: NodePath
var velocity: Vector3    		= Vector3.ZERO
var targets_to_attack:Array 	= [] setget set_targets_to_attack
var target						= null
var actual_health:float			= total_health
var target_pos: Vector3 		= Vector3()
var ready_to_hit: bool 			= true

func _ready() -> void:
	pass

func _physics_process(delta):
	if !targets_to_attack.empty():
		if !is_instance_valid(target):
			target_pos = self.translation
		else:
			target_pos = target.translation
	if target and self.is_on_floor():
		look_at(target_pos, Vector3.UP)
		rotation.x = 0
		velocity = -transform.basis.z * speed
		if transform.origin.distance_to(target_pos) < 1.5:
			target = null
			velocity = Vector3.ZERO
	#Si puede atacar
	if ray_cast.is_colliding():
		var temp = ray_cast.get_collider()
		if ready_to_hit and temp.is_in_group("enemy"):
			temp.hurt(damage)
			ready_to_hit = false
			if clase == UNIT_STATS.classes.esfera:
				queue_free()
			$Timer.start()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector3.UP)

# Funciones:
func hurt(_damage: float) -> void:
	actual_health = actual_health - _damage
	HealthBarr.update_bar(actual_health,total_health)
	if actual_health <= 0:
		queue_free()

func get_nearest_target():
	var target_to_move = targets_to_attack[0]
	var dist_to_target_to_move = target_to_move.translation.distance_to(self.translation)
	for element in targets_to_attack:
		var nearest_dist = element.translation.distance_to(self.translation)
		if dist_to_target_to_move > nearest_dist:
			target_to_move = element
			dist_to_target_to_move = element.translation.distance_to(self.translation)
	return target_to_move
	
# Funciones set&get:
func set_stats(	_value) -> void:
	total_health = _value["Health"]
	damage 		 = _value["Damage"]
	armor		 = _value["Armor"]
	speed		 = _value["Speed"]
	clase		 = _value["Type"]
	match _value["Type"]:
		UNIT_STATS.classes.triangulo:
			$Mallas/Triangulo.visible = true
		UNIT_STATS.classes.cubo:
			$Mallas/Cubo.visible = true
		UNIT_STATS.classes.esfera:
			$Mallas/Esfera.visible = true

func set_targets_to_attack(_value: Array) -> void:
	targets_to_attack = _value
	if !targets_to_attack.empty():
		target = get_nearest_target()

func _on_Timer_timeout() -> void:
	ready_to_hit = true


func _on_KinematicBody_script_changed() -> void:
	#solo para debug:
	#actualiza los stats cuando ocurre un cambio en el script, 
	print("Se cambio el script")
	pass # Replace with function body.
