extends WindowDialog

var recursos: 	  float = 10
var triangulito:  	int = 0
var cubito: 	  	int = 0
var esferitas: 		int = 0
var gold: 			int = 10 setget set_gold

var delay_unit_1:	int = 2
var delay_unit_2:	int = 0
var delay_unit_3:	int = 0

signal spawn_units(army)

func _ready() -> void:
	pass

func set_gold(_value:int)-> void:
	gold = _value
	recursos = _value
	$ProgressBar.max_value = gold
	$ProgressBar.value = gold

#Señales
func _on_Button_less_pressed() -> void:
	if recursos < gold and triangulito > 0:
		recursos += UNIT_STATS.triangulo["Cost"]
		if triangulito > 0:
			triangulito -= 1
		$Label_unit.text=String(triangulito)
		$ProgressBar.value = recursos

func _on_Button_up_pressed() -> void:
	if recursos > 0:
		recursos -= UNIT_STATS.triangulo["Cost"]
		triangulito += 1
		$Label_unit.text=String(triangulito)
		$ProgressBar.value = recursos

func _on_Button_less2_pressed() -> void:
	if recursos < 10 and cubito > 0:
		recursos += UNIT_STATS.cubo["Cost"]
		if cubito>0:
			cubito -= 1
		$Label_unit2.text=String(cubito)
		$ProgressBar.value = recursos


func _on_Button_up2_pressed() -> void:
	if recursos > 0:
		recursos -= UNIT_STATS.cubo["Cost"]
		cubito += 1
		$Label_unit2.text=String(cubito)
		$ProgressBar.value = recursos



func _on_Button_less3_pressed() -> void:
	if recursos < 10 and esferitas > 0:
		recursos += UNIT_STATS.esfera["Cost"]
		if esferitas>0:
			esferitas -= 1
		$Label_unit3.text=String(esferitas)
		$ProgressBar.value = recursos


func _on_Button_up3_pressed() -> void:
	if recursos > 0:
		recursos -= UNIT_STATS.esfera["Cost"]
		esferitas += 1
		$Label_unit3.text=String(esferitas)
		$ProgressBar.value = recursos

func _on_Button_pressed() -> void:
	var army= {	"triangulitos": triangulito,
				"cubitos": cubito,
				"esferitas":esferitas,
				"delay_unit_1": delay_unit_1,
				"delay_unit_2": delay_unit_2,
				"delat_unit_3": delay_unit_3
			  }
	emit_signal("spawn_units",army)
	queue_free()
