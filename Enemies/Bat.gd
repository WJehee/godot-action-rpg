extends KinematicBody2D

const DeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

enum {
	IDLE,
	WANDER,
	CHASE
}

onready var stats = $Stats
onready var detectPlayer = $DetectPlayer
onready var sprite = $Sprite

export var ACCELERATION = 300
export var FRICTION = 200
export var MAX_SPEED = 50

var knockback = Vector2.ZERO
var velocity = Vector2.ZERO
var state = CHASE

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		WANDER:
			pass
		CHASE:
			if detectPlayer.can_see_player():
				var player = detectPlayer.player
				var dir = global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(dir * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0

	velocity = move_and_slide(velocity)
			
func seek_player():
	if detectPlayer.can_see_player():
		state = CHASE

func _on_Stats_death():
	var d = DeathEffect.instance()
	d.global_position = global_position
	get_parent().add_child(d)
	queue_free()

func _on_Hurtbox_area_entered(hitbox):
	stats.health -= hitbox.damage
	knockback = hitbox.knockback * 120
