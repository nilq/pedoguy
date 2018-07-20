extends KinematicBody2D

onready var sprite = $Sprite
onready var original_scale = sprite.get_scale()

onready var flame = sprite.get_node("Flame")
onready var original_flame = flame.get_scale()

onready var flame2 = sprite.get_node("Flame2")
onready var original_flame2 = flame.get_scale()

var last_x

var timer = 0

const SPEED = 50000

func _ready():
	flame.hide()
	flame2.hide()

func _process(delta):
	timer += delta * 12
	
	var x = 0
	var y = 0
	
	if Input.is_action_pressed("ui_down"):
		y = 1

	if Input.is_action_pressed("ui_up"):
		y = -1

	if Input.is_action_pressed("ui_right"):
		x = 1

	if Input.is_action_pressed("ui_left"):
		x = -1

	if x != last_x and x != 0:
		sprite.set_scale(Vector2(-x * original_scale.x, original_scale.y))

	self.move_and_slide(Vector2(x, y).normalized() * SPEED * delta)
	
	if Input.is_action_pressed("ui_select"):
		if int(floor(timer)) % 2 == 0:
			flame.show()
			flame2.hide()
		else:
			flame2.show()
			flame.hide()
	else:
		flame.hide()
		flame2.hide()
	
	last_x = x