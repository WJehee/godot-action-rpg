extends Node2D

onready var sprite = $AnimatedSprite

func _ready():
	sprite.frame = 0
	sprite.play("Destroy")

func _on_AnimatedSprite_animation_finished():
	queue_free()
