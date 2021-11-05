extends Node

enum classes {	triangulo, 	#0
				cubo,		#1
				esfera		#2
				}

# Definición de unidades:
var triangulo = {"Type": classes.triangulo,
				 "Health": 10,
				 "Damage": 2,
				 "Armor": 5,
				 "Speed":5
				}

var cubo = 		{"Type": classes.cubo
				,"Health": 20,
				"Damage": 1, 
				"Armor": 5, 
				"Speed": 2 }

var esfera = 	{"Type": classes.esfera,
				 "Health": 5,
				 "Damage": 7,
				 "Armor": 0,
				 "Speed":6
				}
