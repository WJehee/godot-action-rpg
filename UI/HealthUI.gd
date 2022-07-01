extends Control

var health = 4 setget set_health
var max_health = 4 setget set_max_health

onready var empty = $HeartUIEmpty
onready var full = $HeartUIFull

func set_health(v):
	health = clamp(v, 0, max_health)
	if full != null:
		full.rect_size.x = health * 15
	
func set_max_health(v):
	max_health = max(v, 1)
	if empty != null:
		empty.rect_size.x = max_health * 15
	
func _ready():
	self.max_health = PlayerStats.max_health
	self.health = PlayerStats.health
	PlayerStats.connect("health_changed", self, "set_health")
	PlayerStats.connect("max_health_changed", self, "set_max_health")
