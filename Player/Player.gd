extends KinematicBody2D

enum State {
	MOVE,
	ROLL,
	ATTACK
}

export var MAX_SPEED = 80
export var ROLL_SPEED = 120
export var ACCELERATION = 500
export var FRICTION = 500

var velocity = Vector2.ZERO
var state = State.MOVE

onready var animation = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var swordhitbox = $Pivot/SwordHitBox

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	match state:
		State.MOVE:
			move_state(delta)
		State.ATTACK:
			attack_state(delta)
		State.ROLL:
			roll_state(delta)

func _attack_finished():
	state = State.MOVE
	
func _roll_finished():
	state = State.MOVE

func roll_state(delta):
	animation_state.travel("Roll")
	move()

func attack_state(delta):
	animation_state.travel("Attack")

func move_state(delta):
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input = input.normalized()
	
	if input != Vector2.ZERO:
		animation_tree.set("parameters/Run/blend_position", input)
		animation_tree.set("parameters/Idle/blend_position", input)
		animation_tree.set("parameters/Attack/blend_position", input)
		animation_tree.set("parameters/Roll/blend_position", input)
		animation_state.travel("Run")
		swordhitbox.knockback = input
		if Input.is_action_just_pressed("roll"):
			state = State.ROLL
			velocity = input * ROLL_SPEED
		else:
			velocity = velocity.move_toward(input * MAX_SPEED, ACCELERATION * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()
	if Input.is_action_just_pressed("attack"):
		state = State.ATTACK

func move():
	velocity = move_and_slide(velocity)
