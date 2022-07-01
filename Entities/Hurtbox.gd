extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

onready var timer = $Timer
onready var collision = $CollisionShape2D

var invincible = false

signal invincibility_start
signal invincibility_end

func start_invincible(duration):
	self.invincible = true
	timer.start(duration)
	emit_signal("invincibility_start")

func create_hit_effect():
	var e = HitEffect.instance()
	e.global_position = global_position
	var main = get_tree().current_scene
	main.add_child(e)

func _on_Timer_timeout():
	self.invincible = false
	emit_signal("invincibility_end")

func _on_Hurtbox_invincibility_start():
	collision.set_deferred("disabled", true)

func _on_Hurtbox_invincibility_end():
	collision.disabled = false
