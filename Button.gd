extends StaticBody2D

onready var sprite = $AnimatedSprite

signal pressed

func _on_Area2D_area_entered(area):
	emit_signal("pressed")
	sprite.frame = 0
