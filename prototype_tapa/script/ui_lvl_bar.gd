extends TextureProgress

var bar_green 	= preload("res://assets/texture/lvl_barr/mid_green.png")
var bar_red 	= preload("res://assets/texture/lvl_barr/mid_red.png")
var bar_yellow 	= preload("res://assets/texture/lvl_barr/mid_orange.png")

func update_bar(amount : float, full : float) -> void:
	max_value = full
	texture_progress = bar_green
	if amount < 0.65 * full:
		texture_progress = bar_yellow
	if amount < 0.45 * full:
		texture_progress = bar_red
	value = amount
