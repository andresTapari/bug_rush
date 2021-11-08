extends Control

var camera
var target

func _process(delta: float) -> void:
	if camera and target != null:
		self.rect_position=camera.unproject_position(target.translation)

#Funciones:
func unit_info_table(unit):
	$PanelContainer/VBoxContainer/label_name.text = unit.u_name
	$PanelContainer/VBoxContainer/HBoxContainer_Atack/value.text = String(unit.damage)
	$PanelContainer/VBoxContainer/HBoxContainer_Deff/value.text = String(unit.total_health)
	$PanelContainer/VBoxContainer/HBoxContainer_Shield/value.text = String(unit.armor)
	$PanelContainer/VBoxContainer/HBoxContainer_Fire_Rate/value.text = String(unit.fire_rate)

func set_parameters(_camera,_target):
	camera = _camera
	target = _target
	unit_info_table(_target)

func _on_PanelContainer_focus_exited() -> void:
	queue_free()
