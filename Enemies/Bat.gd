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
onready var hurtbox = $Hurtbox
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController

export var ACCELERATION = 300
export var FRICTION = 200
export var MAX_SPEED = 50
export var SOFT_COLLISION = 400
export var MIN_WANDER_TIME = 1
export var MAX_WANDER_TIME = 3

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
			if wanderController.time_left() == 0:
				random_state()
		WANDER:
			seek_player()
			if wanderController.time_left() == 0:
				random_state()
			move_to(wanderController.target_pos, delta)
			if global_position.distance_to(wanderController.target_pos) <= MAX_SPEED * delta:
				random_state()
		CHASE:
			if detectPlayer.can_see_player():
				var player = detectPlayer.player
				move_to(player.global_position, delta)
			else:
				state = IDLE

	velocity += softCollision.get_push_vector() * delta * SOFT_COLLISION
	velocity = move_and_slide(velocity)

func move_to(pos, delta):
	var dir = global_position.direction_to(pos)
	velocity = velocity.move_toward(dir * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func random_state():
	var states = [IDLE, WANDER]
	states.shuffle()
	state = states[0]
	wanderController.start_timer(rand_range(MIN_WANDER_TIME, MAX_WANDER_TIME))

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
	hurtbox.create_hit_effect()
