#tool
extends KinematicBody

#Señales:
signal player_unit_destroyed(_value)

#Escenas:
onready var HIT_COUNTER = preload('res://scenes/hit_counter_3D.tscn')
onready var EXPLOSION = preload('res://scenes/unit_explosion.tscn')

#Nodos:
onready var HealthBarr 	= get_node('HealthBarr3D/Viewport/HealthBarr2D')
onready var ray_cast 	= get_node('RayCast')
onready var tween		= get_node('Tween')
onready var sound_fx	= get_node('AudioStreamPlayer')

#Variables:
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
var actual_health: float		= total_health
var target_pos: Vector3 		= Vector3()
var ready_to_hit: bool 			= true

var trauma: float 				= 0
var trauma_power: int 			= 1
var decay: float 				= 0.8
var max_roll: float  			= 0.1
var offset_shake: Vector3 		= Vector3()
var max_offset: Vector3			= Vector3()

func _ready() -> void:
	#Ajuste de cajas de colision
	tween.interpolate_property($CollisionShape.get_shape(),
								"radius", 0.01, 1, 1,
								Tween.TRANS_LINEAR,
								Tween.EASE_IN_OUT,
								0)
	tween.start()

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
			play_sound("atack_melee")
			$Mesh.set_animation("atack")
			temp.hurt(damage)
			ready_to_hit = false
			if clase == UNIT_STATS.classes.unit_type_3:
				hurt(total_health)
#				queue_free()
			$Timer.start()
#		else:
#			$Mesh.set_animation("walk")	
	else:
		$Mesh.set_animation("walk")	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector3.UP)
	$Mesh.translation += offset_shake
	
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()

# Funciones:
func hurt(_damage: float) -> void:
	actual_health = actual_health - _damage
	HealthBarr.update_bar(actual_health,total_health)
	add_trauma(10)
	var h = HIT_COUNTER.instance()
	h.set_damage(_damage)
	h.transform = self.global_transform
	get_parent().add_child(h)
	if actual_health <= 0:
		emit_signal("player_unit_destroyed",self)
		var E = EXPLOSION.instance()
		E.set_type()
		E.transform = self.global_transform
		get_parent().add_child(E)
		queue_free()

func get_nearest_target():
# warning-ignore:shadowed_variable
	var target_to_move = targets_to_attack[0]
	var dist_to_target_to_move = target_to_move.translation.distance_to(self.translation)
	for element in targets_to_attack:
		var nearest_dist = element.translation.distance_to(self.translation)
		if dist_to_target_to_move > nearest_dist:
			target_to_move = element
			dist_to_target_to_move = element.translation.distance_to(self.translation)
	return target_to_move

#Agregar bibración cuando una unidad percibe daño
func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)
	
func shake():
	var amount = pow(trauma, trauma_power)
	$Mesh.rotation.z = max_roll * amount * rand_range(-1, 1)
	offset_shake.x = max_offset.x * amount * rand_range(-1, 1) 
	offset_shake.y = max_offset.y * amount * rand_range(-1, 1)

func play_sound(media:String)-> void:
	match media:
		"atack_melee":
			sound_fx.stream = load("res://assets/sounds/unit_atack_melee.wav")
			sound_fx.play()
		"atack_explosion":
			sound_fx.stream = load("res://assets/sounds/unit_atack_explosion.wav")
			sound_fx.play()
		"self_explosion":
			sound_fx.stream = load("res://assets/sounds/unit_self_explosion.wav")
			sound_fx.play()

# Funciones set&get:
func set_stats(	_value) -> void:
	total_health  = _value["Health"]
	damage 		  = _value["Damage"]
	armor		  = _value["Armor"]
	speed		  = _value["Speed"]
	clase		  = _value["Type"]
	actual_health = total_health
	match _value["Type"]:
		UNIT_STATS.classes.unit_type_1:
			$Mesh/unit_type_1.visible = true
			$Mesh.set_current_mesh_animation($Mesh/unit_type_1/AnimationPlayer)
		UNIT_STATS.classes.unit_type_2:
			$Mesh/unit_type_2.visible = true
			$Mesh.set_current_mesh_animation($Mesh/unit_type_2/AnimationPlayer)
		UNIT_STATS.classes.unit_type_3:
			$Mesh/unit_type_3.visible = true
			$Mesh.set_current_mesh_animation($Mesh/unit_type_3/AnimationPlayer)

func set_targets_to_attack(_value: Array) -> void:
	targets_to_attack = _value
	if !targets_to_attack.empty():
		target = get_nearest_target()

# Señales
func _on_Timer_timeout() -> void:
	ready_to_hit = true
