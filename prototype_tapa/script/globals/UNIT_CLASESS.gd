extends Node

enum classes {	unit_type_1, 	#0
				unit_type_2,	#1
				unit_type_3		#2
				}

# Definición de unidades:
var unit_type_1 = {
					"Type": classes.unit_type_1,
					"Health": 10,
					"Damage": 2,
					"Armor": 5,
					"Speed":5,
					"price":1
					}

var unit_type_2 = {
					"Type": classes.unit_type_2,
					"Health": 40,
					"Damage": 1, 
					"Armor": 5, 
					"Speed": 3,
					"price":2 
					}

var unit_type_3 = 	{
					"Type": classes.unit_type_3,
					"Health": 5,
					"Damage": 7,
					"Armor": 0,
					"Speed": 6,
					"price":1
					}
