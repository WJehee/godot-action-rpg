extends Node2D

onready var sprite = $Sprite
onready var effect = $Effect

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		sprite.visible = false
		effect.visible = true
		effect.frame = 1
		effect.play("Destroy")

func _ready():
	effect.visible = false

func _on_Effect_animation_finished():
	queue_free()
