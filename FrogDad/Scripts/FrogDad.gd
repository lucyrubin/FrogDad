class_name FrogDad
extends KinematicBody2D

export var speed = 300
export(NodePath) var inventory_path

var screen_size
var state = ""
var velocity
var holding_item = null

func _ready():
	screen_size = get_viewport_rect().size
	
func getInventoryNode():
	return $UserInterface/Inventory
	
func _physics_process(delta):
	z_index = position.y
	velocity = Vector2.ZERO
	if state == "": # move as long as dialogue and inventory aren't active
		if Input.is_action_pressed("move_down"):
			move_down()
		if Input.is_action_pressed("move_up"):
			move_up()
		if Input.is_action_pressed("move_right"):
			move_right()
		if Input.is_action_pressed("move_left"):
			move_left()
			
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			$AnimatedSprite.play()

		else:
			$AnimatedSprite.stop()
	else: 
		$AnimatedSprite.stop()
		
	var _collision = move_and_collide(velocity*delta)

func move_down():
	velocity.y += 1
	$AnimatedSprite.flip_h = false
	$AnimatedSprite.animation = "walk"

func move_up():
	velocity.y -= 1
	$AnimatedSprite.flip_h = false
	$AnimatedSprite.animation = "up"

func move_right():
	velocity.x += 1
	$AnimatedSprite.flip_h = false
	$AnimatedSprite.animation = "right"

func move_left():
	velocity.x -= 1
	$AnimatedSprite.flip_h = true
	$AnimatedSprite.animation = "right"

func toggle_dialogue_box_visibility():
	$DialogueBox.visible = !$DialogueBox.visible

