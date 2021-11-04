extends WindowDialog

var recursos: float = 10
var triangulito: int = 0

signal spawn_units(army)

func _ready() -> void:
	popup()

func _on_Button_less_pressed() -> void:
	if recursos < 10:
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
	var army= {"triangulitos": triangulito}
	emit_signal("spawn_units",army)
	queue_free()
