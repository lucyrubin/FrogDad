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
	$AnimatedSprite.frame = 0
	
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
	
func _process(delta):
	if MasterScript.currentQuestNum == 0:
		$BabyJar.show()
		if $AnimatedSprite.animation == "down_holding":
			$BabyJar.position.x = -6
			$BabyJar.position.y = -20
		elif $AnimatedSprite.animation == "left_holding":
			$BabyJar.position.x = -80
			$BabyJar.position.y = -30
		elif $AnimatedSprite.animation == "right_holding":
			$BabyJar.position.x = 80
			$BabyJar.position.y = -30
		elif $AnimatedSprite.animation == "up_holding":
			$BabyJar.hide()
	elif MasterScript.currentQuestNum == 5:
		$FlyJar.show()
		if $AnimatedSprite.animation == "down_holding":
			$FlyJar.position.x = -6
			$FlyJar.position.y = -20
		elif $AnimatedSprite.animation == "left_holding":
			$FlyJar.position.x = -80
			$FlyJar.position.y = -40
		elif $AnimatedSprite.animation == "right_holding":
			$FlyJar.position.x = 80
			$FlyJar.position.y = -40
		elif $AnimatedSprite.animation == "up_holding":
			$FlyJar.hide()
	
	
func move_down_and_left():
	velocity.x -= 1
	if MasterScript.currentQuestNum == 5 or MasterScript.currentQuestNum == 6 or MasterScript.currentQuestNum == 0:
		$AnimatedSprite.animation = "left_holding"
	elif MasterScript.currentQuestNum == 1:
		$AnimatedSprite.animation = "left_swaddle"
	else:
		$AnimatedSprite.animation = "left"

func move_up_and_left():
	velocity.x -= 1
	if MasterScript.currentQuestNum == 5 or MasterScript.currentQuestNum == 6 or MasterScript.currentQuestNum == 0:
		$AnimatedSprite.animation = "left_holding"
	elif MasterScript.currentQuestNum == 1:
		$AnimatedSprite.animation = "left_swaddle"
	else:
		$AnimatedSprite.animation = "left"
	
func move_up_and_right():
	velocity.x += 1
	velocity.y -= 1
	if MasterScript.currentQuestNum == 5 or MasterScript.currentQuestNum == 6 or MasterScript.currentQuestNum == 0:
		$AnimatedSprite.animation = "right_holding"
	elif MasterScript.currentQuestNum == 1:
		$AnimatedSprite.animation = "right_swaddle"
	else:
		$AnimatedSprite.animation = "right"

func move_down_and_right():
	velocity.x += 1
	velocity.y += 1
	if MasterScript.currentQuestNum == 5 or MasterScript.currentQuestNum == 6 or MasterScript.currentQuestNum == 0:
		$AnimatedSprite.animation = "right_holding"
	elif MasterScript.currentQuestNum == 1:
		$AnimatedSprite.animation = "right_swaddle"
	else:
		$AnimatedSprite.animation = "right"

# -1 means the intro of getting the note
# 0 is after the note cut scene (baby jar cut scene/swaddle quest)
# 1 is the log quest
# 2 is go get flies from jimothy (talk to jimothy)
# 3 is get lettuce for jimothy
# 4 is bring the lettuce to jimothy
# 5 is bring the flies home
# 6 is the odie riddles

func move_down():
	velocity.y += 1
	if MasterScript.currentQuestNum == 5 or MasterScript.currentQuestNum == 6 or MasterScript.currentQuestNum == 0:
		$AnimatedSprite.animation = "down_holding"
	elif MasterScript.currentQuestNum == 1:
		$AnimatedSprite.animation = "down_swaddle"
	else:
		$AnimatedSprite.animation = "down"

func move_up():
	velocity.y -= 1
	if MasterScript.currentQuestNum == 5 or MasterScript.currentQuestNum == 6 or MasterScript.currentQuestNum == 0:
		$AnimatedSprite.animation = "up_holding"
	elif MasterScript.currentQuestNum == 1:
		$AnimatedSprite.animation = "up_swaddle"
	else:
		$AnimatedSprite.animation = "up"

func move_right():
	velocity.x += 1
	if MasterScript.currentQuestNum == 5 or MasterScript.currentQuestNum == 6 or MasterScript.currentQuestNum == 0:
		$AnimatedSprite.animation = "right_holding"
	elif MasterScript.currentQuestNum == 1:
		$AnimatedSprite.animation = "right_swaddle"
	else:
		$AnimatedSprite.animation = "right"

func move_left():
	velocity.x -= 1
	if MasterScript.currentQuestNum == 5 or MasterScript.currentQuestNum == 6 or MasterScript.currentQuestNum == 0:
		$AnimatedSprite.animation = "left_holding"
	elif MasterScript.currentQuestNum == 1:
		$AnimatedSprite.animation = "left_swaddle"
	else:
		$AnimatedSprite.animation = "left"

func toggle_dialogue_box_visibility(dialogue, dialogue_name):
	$DialogueBox.visible = true
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

func set_fly_jar_visiblity(visiblity):
	$FlyJar.visible = visiblity
