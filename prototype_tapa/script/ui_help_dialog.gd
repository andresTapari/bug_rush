extends MarginContainer

#Nodos

onready var text_box = get_node('VBoxContainer/RichTextLabel')

var current_idx = 1

func _ready() -> void:
	set_text(HELP.helps_dialogs.entering_level)
	text_box.connect('meta_clicked',self,"handle_meta_clicked")
	
func set_text(_value)->void:
	visible = SETUP.current["help_en"]
	$VBoxContainer/HBoxContainer/CheckBox.pressed = !SETUP.current["help_en"]
	text_box.visible_characters = 0
	text_box.scroll_to_line(0)
	text_box.bbcode_text = HELP.get_dialog(_value)
	$Timer.start()

func _on_Timer_timeout() -> void:
	text_box.visible_characters += 1

func handle_meta_clicked(meta) -> void:
	current_idx += 1
	if current_idx < 5:
		set_text(current_idx)

func _on_CheckBox_toggled(button_pressed: bool) -> void:
	visible = !button_pressed
	SETUP.current["help_en"] = !button_pressed


func _on_CheckBox_mouse_entered() -> void:
	var tween = get_node("Tween")
	tween.interpolate_property($VBoxContainer/HBoxContainer/CheckBox, "modulate",
		Color(1,1,1,0.2), Color(1,1,1,1), 0.40,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()



func _on_CheckBox_mouse_exited() -> void:
	var tween = get_node("Tween")
	tween.interpolate_property($VBoxContainer/HBoxContainer/CheckBox, "modulate",
		Color(1,1,1,1), Color(1,1,1,.2), 0.40,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
