extends WindowDialog

var recursos: 	  float = 10
var triangulito:  	int = 0
var cubito: 	  	int = 0
var esferitas: 		int = 0

signal spawn_units(army)

func _ready() -> void:
	pass

func _on_Button_less_pressed() -> void:
	if recursos < 10 and triangulito > 0:
		recursos += 1
		if triangulito>0:
			triangulito -= 1
		$Label_unit.text=String(triangulito)
		$ProgressBar.value = recursos

func _on_Button_up_pressed() -> void:
	if recursos > 0:
		recursos -= 1
		triangulito += 1
		$Label_unit.text=String(triangulito)
		$ProgressBar.value = recursos

func _on_Button_pressed() -> void:
	var army= {	"triangulitos": triangulito, 
				"cubitos": cubito,
				"esferitas":esferitas
			  }
	emit_signal("spawn_units",army)
	queue_free()


func _on_Button_less2_pressed() -> void:
	if recursos < 10 and cubito > 0:
		recursos += 2
		if cubito>0:
			cubito -= 1
		$Label_unit2.text=String(cubito)
		$ProgressBar.value = recursos


func _on_Button_up2_pressed() -> void:
	if recursos > 0:
		recursos -= 2
		cubito += 1
		$Label_unit2.text=String(cubito)
		$ProgressBar.value = recursos



func _on_Button_less3_pressed() -> void:
	if recursos < 10 and esferitas > 0:
		recursos += 2
		if esferitas>0:
			esferitas -= 1
		$Label_unit3.text=String(esferitas)
		$ProgressBar.value = recursos


func _on_Button_up3_pressed() -> void:
	if recursos > 0:
		recursos -= 3
		esferitas += 1
		$Label_unit3.text=String(esferitas)
		$ProgressBar.value = recursos
