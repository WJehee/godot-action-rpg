extends KinematicBody2D

enum State {
	MOVE,
	ROLL,
	ATTACK
}

const MAX_SPEED = 80
const ACCELERATION = 500
const FRICTION = 500

var velocity = Vector2.ZERO
var state = State.MOVE

onready var animation = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

func _ready():
	animation_tree.active = true

func _process(delta):
	match state:
		State.MOVE:
			move(delta)
		State.ATTACK:
			attack(delta)
		State.ROLL:
			pass

func attack(delta):
	animation_state.travel("Attack")
	velocity = Vector2.ZERO
	
func move(delta):
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input = input.normalized()
	
	if input != Vector2.ZERO:
		animation_tree.set("parameters/Run/blend_position", input)
		animation_tree.set("parameters/Idle/blend_position", input)
		animation_tree.set("parameters/Attack/blend_position", input)
		animation_state.travel("Run")
		velocity = velocity.move_toward(input * MAX_SPEED, ACCELERATION * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)
	if Input.is_action_just_pressed("attack"):
		state = State.ATTACK

func _attack_finished():
	state = State.MOVE

