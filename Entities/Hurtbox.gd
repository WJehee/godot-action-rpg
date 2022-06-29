extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

export var show_hit = true

func _on_Hurtbox_area_entered(area):
	if show_hit:
		var e = HitEffect.instance()
		e.global_position = global_position
		var main = get_tree().current_scene
		main.add_child(e)
