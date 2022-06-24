extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		var Effect = load("res://Effects/GrassEffect.tscn")
		var e = Effect.instance()
		var world = get_tree().current_scene
		world.add_child(e)
		e.global_position = global_position
		
		queue_free()
