extends Node

enum classes {	unit_type_1, 	#0
				unit_type_2,	#1
				unit_type_3,	#2
				enemy_type_1,	#3
				enemy_type_2,	#4
				enemy_type_3	#5
				}

# Definición de unidades:
var unit_type_1 = {
					"Type": classes.unit_type_1,
					"Name":'unit_1',
					"Health": 10,
					"Damage": 2,
					"Armor": 5,
					"Speed":5,
					"price":1
					}

var unit_type_2 = {
					"Type": classes.unit_type_2,
					"Name": 'unit_2',
					"Health": 20,
					"Damage": 1, 
					"Armor": 5, 
					"Speed": 3,
					"price":2 
					}

var unit_type_3 = 	{
					"Type": classes.unit_type_3,
					"Name": "unit_3",
					"Health": 5,
					"Damage": 7,
					"Armor": 0,
					"Speed": 6,
					"price": 1
					}

#enemy fence
var enemy_type_1 = {
					"Type": classes.enemy_type_1,
					"Name": "Enemy Fence",
					"Health": 15,
					"Damage": 0,
					"Armor": 5,
					"Speed": 0,
					"FR": 0,
					"price": 0,
					"Score": 50
}

#enemy tower
var enemy_type_2 = {
					"Type": classes.enemy_type_2,
					"Name": "Enemy Tower",
					"Health": 10,
					"Damage": 3,
					"Armor": 0,
					"Speed": 0,
					"FR": 1,
					"price": 0,
					"Score": 200
}

