extends Node

onready var from = $From.position
onready var to = $To.position

var moving = false
var pos = 0

export var SPEED = 0.4

signal move_to(pos)

func _physics_process(delta):
	if moving:
		pos += SPEED * delta
		if pos <= 1:
			var p = from.linear_interpolate(to, pos)
			emit_signal("move_to", p)
		else:
			moving = false

func _on_Button_pressed():
	moving = true
