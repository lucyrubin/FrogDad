class_name FrogDad
# Code without acceleration and friction
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
	$QuestLabel.text = "Current quest: " + MasterScript.quest_state + " \nSprite image: " + MasterScript.sprite_image
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
#			print("z index: ", z_index, " y position: ", position.y)
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


#Code with acceleration and friction
#extends KinematicBody2D
#
#const ACCELERATION = 400 # feel free to change these three constants up to try different things
#const MAX_SPEED = 100
#const FRICTION = 400
#var velocity = Vector2.ZERO
#onready var sprite = $Sprite
#
#var screen_size
#var state = ""
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	screen_size = get_viewport_rect().size
#
#
#func _physics_process(delta):
#	var input_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
#	var input_y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
#
#	if state == "": # move as long as dialogue and inventory aren't active
#		if input_x < 0:
#			$AnimatedSprite.flip_h = true
#			$AnimatedSprite.animation = "right"
#		elif input_x > 0:
#			$AnimatedSprite.flip_h = false
#			$AnimatedSprite.animation = "right"
#
#		if input_y < 0:
#			$AnimatedSprite.flip_h = false
#			$AnimatedSprite.animation = "walk"
#		elif input_y > 0:
#			$AnimatedSprite.flip_h = true
#			$AnimatedSprite.animation = "up"
#
#		if input_x != 0 || input_y != 0:
#			velocity = velocity.move_toward(Vector2(input_x, -input_y) * MAX_SPEED, ACCELERATION * delta)
#
#			#velocity = velocity.normalized() * MAX_SPEED
#			$AnimatedSprite.play()
#		else:
#			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
#			$AnimatedSprite.stop()
#
#
#
#
#		velocity = move_and_slide(velocity, Vector2.UP)
#
#
#	var _collision = move_and_collide(velocity*delta)
#
