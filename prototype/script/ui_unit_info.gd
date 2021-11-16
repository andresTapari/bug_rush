extends Control

var camera
var target

func _process(_delta: float) -> void:
	if camera and target != null:
		if is_instance_valid(target):
			self.rect_position=camera.unproject_position(target.translation)
		else:
			queue_free()

#Funciones:
func unit_info_table(unit):
	$PanelContainer/VBoxContainer/label_name.text = unit.u_name
	$PanelContainer/VBoxContainer/HBoxContainer_Atack/value.text = String(unit.damage)
	$PanelContainer/VBoxContainer/HBoxContainer_Deff/value.text = String(unit.total_health)
	$PanelContainer/VBoxContainer/HBoxContainer_Shield/value.text = String(unit.armor)
	$PanelContainer/VBoxContainer/HBoxContainer_Fire_Rate/value.text = String(unit.fire_rate)
#	if unit.damage != 0:
#		$PanelContainer/VBoxContainer/HBoxContainer_Atack/value.text = String(unit.damage)
#	else:
#		$PanelContainer/VBoxContainer/HBoxContainer_Atack.visible = 0
#	$PanelContainer/VBoxContainer/HBoxContainer_Deff/value.text = String(unit.total_health)
#
#	if unit.armor != 0:
#		$PanelContainer/VBoxContainer/HBoxContainer_Shield/value.text = String(unit.armor)
#	else:
#		$PanelContainer/VBoxContainer/HBoxContainer_Shield.visible = 0
#
#	if unit.fire_rate != 0:
#		$PanelContainer/VBoxContainer/HBoxContainer_Fire_Rate/value.text = String(unit.fire_rate)
#	else:
#		$PanelContainer/VBoxContainer/HBoxContainer_Fire_Rate.visible = 0

func set_parameters(_camera,_target):
	camera = _camera
	target = _target
	unit_info_table(_target)

func _on_PanelContainer_focus_exited() -> void:
	queue_free()
