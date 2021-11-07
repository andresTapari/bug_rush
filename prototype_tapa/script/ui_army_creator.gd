extends WindowDialog

#Variables
var recursos:		float = 10

var unit_1:			int = 0
var unit_2: 		int = 0
var unit_3:			int = 0

var unit_1_delay:	int = 0
var unit_2_delay:	int = 0
var unit_3_delay:	int = 0

#Señales
signal spawn_units(army)

func _ready() -> void:
	pass

#Señales:
func _on_Button_less_pressed() -> void:
	if unit_1 > 0:
		recursos += UNIT_STATS.triangulo.price
		unit_1 -= 1
		$gd/gdTriangulo/Label_unit.text=String(unit_1)
		$gd/ProgressBar.value = recursos

func _on_Button_up_pressed() -> void:
	if recursos >= UNIT_STATS.triangulo.price:
		recursos -= 1
		unit_1 += 1
		$gd/gdTriangulo/Label_unit.text=String(unit_1)
		$gd/ProgressBar.value = recursos

func _on_Button_pressed() -> void:
	var army= {
				"unit_1": unit_1, 
				"unit_2": unit_2,
				"unit_3": unit_3,
				"unit_1_delay": unit_1_delay, 
				"unit_2_delay": unit_2_delay,
				"unit_3_delay": unit_3_delay
			  }
	emit_signal("spawn_units",army)
	queue_free()


func _on_Button_less2_pressed() -> void:
	if unit_2 > 0:
		recursos += UNIT_STATS.cubo.price
		unit_2 -= 1
		$gd/gdCubo/Label_unit.text=String(unit_2)
		$gd/ProgressBar.value = recursos


func _on_Button_up2_pressed() -> void:
	if recursos >= UNIT_STATS.cubo.price:
		recursos -= UNIT_STATS.cubo.price
		unit_2 += 1
		$gd/gdCubo/Label_unit.text=String(unit_2)
		$gd/ProgressBar.value = recursos

func _on_Button_less3_pressed() -> void:
	if unit_3 > 0:
		recursos += UNIT_STATS.esfera.price
		unit_3 -= 1
		$gd/gdEsfera/Label_unit.text=String(unit_3)
		$gd/ProgressBar.value = recursos


func _on_Button_up3_pressed() -> void:
	if recursos >= UNIT_STATS.esfera.price:
		recursos -= UNIT_STATS.esfera.price
		unit_3 += 1
		$gd/gdEsfera/Label_unit.text=String(unit_3)
		$gd/ProgressBar.value = recursos


func _on_ButtonD_less_pressed():
		if unit_3_delay > 0:
			unit_3_delay -= 1
			$gd/gdTriangulo/Delay.text=String(unit_3_delay)


func _on_ButtonD_up_pressed():
		unit_3_delay += 1
		$gd/gdTriangulo/Delay.text=String(unit_3_delay)



func _on_ButtonD_less2_pressed():
	if unit_2_delay >0:
		unit_2_delay -=1
		$gd/gdCubo/Delay.text=String(unit_2_delay)

func _on_ButtonD_up2_pressed():
	unit_2_delay+=1
	$gd/gdCubo/Delay.text=String(unit_2_delay)
	

func _on_ButtonD_less3_pressed():
	if unit_3_delay>0:
		unit_3_delay-=1
		$gd/gdEsfera/Delay.text=String(unit_3_delay)

func _on_ButtonD_up3_pressed():
	unit_3_delay+=1
	$gd/gdEsfera/Delay.text=String(unit_3_delay)
