extends Node2D

onready var sprite = $Sprite
onready var effect = $Effect


func _ready():
	effect.visible = false

func _on_Effect_animation_finished():
	queue_free()

func _on_Hurtbox_area_entered(area):
	destroy()

func destroy():
	sprite.visible = false
	effect.visible = true
	effect.frame = 1
	effect.play("Destroy")
