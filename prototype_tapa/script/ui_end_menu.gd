extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/VBoxContainer/Score.text = String(LVL_MASTER.player_info["score"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Button_pressed() -> void:
	SOUND_FX.button_play("back/cancel")
	var lvl_selection = "res://lvls/main_menu.tscn"
	#warning-ignore:return_value_discarded
	get_tree().change_scene(lvl_selection)
