extends Camera2D

onready var tl = $Limits/TL
onready var br = $Limits/BR

func _ready():
	limit_top = tl.position.y
	limit_left = tl.position.x
	limit_bottom = br.position.y
	limit_right = br.position.x
