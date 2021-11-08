extends TextureProgress

var bar_green 	= preload("res://assets/texture/health_barr/barHorizontal_green_mid 200.png")
var bar_red 	= preload("res://assets/texture/health_barr/barHorizontal_red_mid 200.png")
var bar_yellow 	= preload("res://assets/texture/health_barr/barHorizontal_yellow_mid 200.png")

func _ready() -> void:
	hide()

func update_bar(amount, full) -> void:
	if amount < full:
		show()
	texture_progress = bar_green
	if amount < 0.65 * full:
		texture_progress = bar_yellow
	if amount < 0.45 * full:
		texture_progress = bar_red
	value = amount
