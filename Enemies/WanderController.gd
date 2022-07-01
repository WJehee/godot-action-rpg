extends Node2D

export var WANDER_RANGE = 32

onready var start_pos = global_position
onready var target_pos = global_position

onready var timer = $Timer

func update_target():
	var target = Vector2(rand_range(-WANDER_RANGE, WANDER_RANGE), rand_range(-WANDER_RANGE, WANDER_RANGE))
	target_pos = start_pos + target

func _on_Timer_timeout():
	update_target()

func time_left():
	return timer.time_left
	
func start_timer(t):
	timer.start(t)
