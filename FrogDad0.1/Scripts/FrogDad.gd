extends KinematicBody2D


export var speed = 400;
#TODO: add acceleration and friction? Just to advance the movement quality a bit
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


func _physics_process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.animation = "walk"
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.animation = "up"
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.animation = "right"
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.animation = "right"

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	var _collision = move_and_collide(velocity*delta)
	
	
