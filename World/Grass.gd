extends Node2D

onready var sprite = $Sprite

const GrassEffect = preload("res://Effects/GrassEffect.tscn")

func _on_Hurtbox_area_entered(area):
	var e = GrassEffect.instance()
	e.global_position = global_position
	get_parent().add_child(e)
	queue_free()
