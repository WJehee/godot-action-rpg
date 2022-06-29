extends Node

export var max_health = 1 setget set_max_health
var health = max_health setget set_health

signal death
signal health_changed(v)
signal max_health_changed(v)

func set_health(v):
	health = v
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("death")

func set_max_health(v):
	max_health = v
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func _ready():
	self.health = max_health
