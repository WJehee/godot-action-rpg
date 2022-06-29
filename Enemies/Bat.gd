extends KinematicBody2D

const DeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

onready var stats = $Stats

var knockback = Vector2.ZERO

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

func _on_HitBox_area_entered(hitbox):
	stats.health -= hitbox.damage
	knockback = hitbox.knockback * 120

func _on_Stats_death():
	var d = DeathEffect.instance()
	d.global_position = global_position
	get_parent().add_child(d)
	queue_free()
