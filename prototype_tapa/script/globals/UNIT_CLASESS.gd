extends Node

enum classes {	unit_type_1, 	#0
				unit_type_2,	#1
				unit_type_3,	#2
#				unit_type_n,	#n
				enemy_type_1,	#3
				enemy_type_2,	#4
				enemy_type_3	#5
				}

# Definición de unidades:
# Ant
var unit_type_1 = {
					"Type": classes.unit_type_1,
					"Name":'Warrior Ant',
					"Health": 10,
					"Damage": 2,
					"Armor": 5,
					"Speed":5,
					"Lvl":1,
					"price":1
					}

# Bettle
var unit_type_2 = {
					"Type": classes.unit_type_2,
					"Name": 'Tank Bettle',
					"Health": 20,
					"Damage": 1, 
					"Armor": 5, 
					"Speed": 3,
					"Lvl":1,
					"price":2 
					}

# Ladybug
var unit_type_3 = 	{
					"Type": classes.unit_type_3,
					"Name": "Kamikaze Ladybug",
					"Health": 5,
					"Damage": 7,
					"Armor": 0,
					"Speed": 6,
					"Lvl":1,
					"price": 1
					}

#var unit_type_3 = 	{
#					"Type": classes.unit_type_3,
#					"Name": "unit_3",
#					"Health": 5,
#					"Damage": 7,
#					"Armor": 0,
#					"Speed": 6,
#					"Lvl":1,
#					"price": 1
#					}

# Enemy Brick
var enemy_type_1 = {
					"Type": classes.enemy_type_1,
					"Name": "Brick",
					"Health": 15,
					"Damage": 0,
					"Armor": 5,
					"Speed": 0,
					"FR": 0,
					"Lvl":1,
					"price": 0,
					"Score": 50
}

# Enemy tank
var enemy_type_2 = {
					"Type": classes.enemy_type_2,
					"Name": "Tank",
					"Health": 10,
					"Damage": 3,
					"Armor": 0,
					"Speed": 0,
					"FR": 1,
					"Lvl":1,
					"price": 0,
					"Score": 200
}

# Enemy Bug Spray
var enemy_type_3 = {
					"Type": classes.enemy_type_3,
					"Name": "Bug Spray",
					"Health": 10,
					"Damage": 3,
					"Armor": 0,
					"Speed": 0,
					"FR": 0.5,
					"Lvl":1,
					"price": 0,
					"Score": 200
}
# Funciones

func get_unit_stats(_index: int) -> Dictionary:
	match _index:
		1:
			return unit_type_1
		2:
			return unit_type_2
		3:
			return unit_type_3
#	Completar aca para agregar mas unideades
#		4:
#			return unit_type_4
	return {}
