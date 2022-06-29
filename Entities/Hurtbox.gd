extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

func _on_Hurtbox_area_entered(area):
	var e = HitEffect.instance()
	e.global_position = global_position
	var main = get_tree().current_scene
	main.add_child(e)
