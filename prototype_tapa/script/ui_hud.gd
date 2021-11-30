extends CanvasLayer

signal stop_round

# nodos:
onready var lvl_progress_barr = get_node('VBoxContainer/TextureProgress')
onready var btn_prepare 	  = get_node('VBoxContainer/btn_preparar_ataque')
onready var army_generator	  = get_node('ui_army_spawner')
onready var score_counter	  = get_node('MarginContainer/VBoxContainer/HBoxContainer3/Label_score_counter')
onready var lvl_counter		  = get_node('MarginContainer2/VBoxContainer/HBoxContainer2/Label_lvl_counter')
onready var coins		  	  = get_node('MarginContainer/VBoxContainer/HBoxContainer/Label_coint_counter')
#onready var score_dialog	  = get_node("ui_score_dialog")

var player_state: String = "preparar"
var current_lvl: int = 0

# variables:
var enemigos: float = 0

func _ready() -> void:
	army_generator.connect('attack_started',self,"handle_attack_started")
	lvl_progress_barr.value = 0
	current_lvl = get_parent().index_lvl
	lvl_counter.text = String(current_lvl)
	coins.text=String(LVL_MASTER.player_info["coins"])

func _input(event) -> void:
	if  event is InputEventKey and Input.is_action_pressed("pause"):
		print(event)
		$ui_pause_dialog.popup()

func update_score(_value: int) -> void:
	score_counter.text = String(_value)

# señales:
func _on_Button_pressed() -> void:
	pass

func _on_btn_preparar_ataque_pressed() -> void:
	SOUND_FX.button_play("acept")
#	$ui_help_dialog.set_text(2)
	if LVL_MASTER.player_info["coins"] >= 1 or army_generator.units_in_queue():
		$ui_help_dialog.set_text(HELP.helps_dialogs.spawner_page_1)
		if player_state == "preparar":
			army_generator.popup()
		elif player_state == "atacando":
			emit_signal("stop_round")
	else:
		$ui_game_over_dialog.popup()
		$ui_help_dialog.set_text(HELP.helps_dialogs.game_over)
func handle_attack_started():
	$ui_help_dialog.set_text(HELP.helps_dialogs.spawner_focus_start_attack)
	coins.text = String(LVL_MASTER.player_info["coins"])
	btn_prepare.text = "Stop Atack"
	player_state = "atacando"

func _on_ui_pause_dialog_popup_hide():
	get_tree().paused = false

func _on_ui_pause_dialog_about_to_show():
	get_tree().paused = true

func _on_ui_score_dialog_visibility_changed():
	get_tree().paused = !get_tree().paused


func _on_Control_mouse_entered() -> void:
	$ui_help_dialog.set_text(HELP.helps_dialogs.hud_focus_mouse_help)
	var tween = get_node("Mouse_icon/Tween")
	tween.interpolate_property($Mouse_icon, "modulate",
		Color(1,1,1,0.2), Color(1,1,1,1), 0.40,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_Control_mouse_exited() -> void:
	var tween = get_node("Mouse_icon/Tween")
	tween.interpolate_property($Mouse_icon, "modulate",
		Color(1,1,1,1), Color(1,1,1,0.2), 0.40,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_HBoxContainer_score_mouse_entered() -> void:
	$ui_help_dialog.set_text(HELP.helps_dialogs.hud_focus_score)

func _on_HBoxContainer_mouse_entered() -> void:
	$ui_help_dialog.set_text(HELP.helps_dialogs.hud_focus_coins)

func _on_TextureProgress_mouse_entered() -> void:
	$ui_help_dialog.set_text(HELP.helps_dialogs.hud_focus_progress_bar)

func _on_btn_preparar_ataque_mouse_entered() -> void:
	$ui_help_dialog.set_text(HELP.helps_dialogs.hud_focus_attack_btn)

func _on_MarginContainer2_mouse_entered() -> void:
	$ui_help_dialog.set_text(HELP.helps_dialogs.hud_focus_current_lvl)
