class_name FrogDad
extends KinematicBody2D

export var speed = 300
export(NodePath) var inventory_path

var screen_size
var velocity
var holding_item = null

func _ready():
	velocity = Vector2.ZERO
	screen_size = get_viewport_rect().size
	
func getInventoryNode():
	return $UserInterface/Inventory
	
func _physics_process(delta):
	var texture_height = $AnimatedSprite.get_sprite_frames().get_frame("down",0).get_height()
	z_index = global_position.y + (texture_height / 2)
	velocity = Vector2.ZERO
	
	if MasterScript.frog_dad_state == "": # move as long as dialogue and inventory aren't active
		if Input.is_action_pressed("move_down") and Input.is_action_pressed("move_left"):
			move_down_and_left()
		elif Input.is_action_pressed("move_down") and Input.is_action_pressed("move_right"):
			move_down_and_right()
		elif Input.is_action_pressed("move_up") and Input.is_action_pressed("move_left"):
			move_up_and_left()
		elif Input.is_action_pressed("move_up") and Input.is_action_pressed("move_right"):
			move_up_and_right()
		else:
			if Input.is_action_pressed("move_down"):
				move_down()
			if Input.is_action_pressed("move_up"):
				move_up()
			if Input.is_action_pressed("move_right"):
				move_right()
			if Input.is_action_pressed("move_left"):
				move_left()
		if _is_moving():
			velocity = velocity.normalized() * speed
			if !$AnimatedSprite.playing:
				$AnimatedSprite.play()
				$AnimatedSprite.frame += 1
	else: 
		$AnimatedSprite.stop()

	var _collision = move_and_collide(velocity*delta)

func move_down_and_left():
	velocity.x -= 1
	velocity.y += 1
	$AnimatedSprite.flip_h = false
	$AnimatedSprite.animation = "left"

func move_up_and_left():
	velocity.x -= 1
	velocity.y -= 1
	$AnimatedSprite.flip_h = false
	$AnimatedSprite.animation = "left"
	
func move_up_and_right():
	velocity.x += 1
	velocity.y -= 1
	$AnimatedSprite.flip_h = false
	$AnimatedSprite.animation = "right"

func move_down_and_right():
	velocity.x += 1
	velocity.y += 1
	$AnimatedSprite.flip_h = false
	$AnimatedSprite.animation = "right"
	
func move_down():
	velocity.y += 1
	$AnimatedSprite.flip_h = false
	$AnimatedSprite.animation = "down"

func move_up():
	velocity.y -= 1
	$AnimatedSprite.flip_h = false
	$AnimatedSprite.animation = "up"

func move_right():
	velocity.x += 1
	$AnimatedSprite.animation = "right"

func move_left():
	velocity.x -= 1
#	$AnimatedSprite.flip_h = true
	$AnimatedSprite.animation = "left"

func toggle_dialogue_box_visibility(dialogue, dialogue_name):
	$DialogueBox.visible = true
	print($DialogueBox.visible)
	$DialogueBox.show_dialog_box(dialogue, dialogue_name)

func toggle_riddle_visibility(riddle):
	$DialogueBox.visible = true
	$DialogueBox/RiddleHUD.visible = false
	$DialogueBox.play_riddle(riddle)
	
func _is_moving():
	return velocity.length() > 0

func _animation_is_at_rest():
	return $AnimatedSprite.frame == 0 or \
		   $AnimatedSprite.frame == $AnimatedSprite.frames.get_frame_count($AnimatedSprite.animation) / 2

func _on_AnimatedSprite_frame_changed():
	if !_is_moving() and _animation_is_at_rest():
		$AnimatedSprite.stop()
