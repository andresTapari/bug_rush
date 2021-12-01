extends Spatial

var current_animation_player: AnimationPlayer

func set_current_mesh_animation(_current_animation_player):
	current_animation_player = _current_animation_player

func set_animation(anim_name):
	if current_animation_player.has_animation(anim_name):
		current_animation_player.play(anim_name)
