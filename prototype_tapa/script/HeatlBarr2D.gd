extends TextureProgress

var bar_green 	= preload("res://assets/texture/health_barr/health_bar_mid_green.png")
var bar_red 	= preload("res://assets/texture/health_barr/health_bar_mid_red.png")
var bar_yellow 	= preload("res://assets/texture/health_barr/health_bar_mid_orange.png")

func _ready() -> void:
	hide()

func update_bar(amount : float, full : float) -> void:
	max_value = full
	if amount < full:
		show()
	texture_progress = bar_green
	if amount < 0.65 * full:
		texture_progress = bar_yellow
	if amount < 0.45 * full:
		texture_progress = bar_red
	value = amount
