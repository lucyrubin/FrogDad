#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk
extends KinematicBody2D


const ACCELERATION = 960
const MAX_SPEED = 155
const FRICTION = 900
var velocity = Vector2.ZERO
onready var sprite = $Sprite

func _physics_process(delta):
	var input_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if input_x < 0:
		sprite.flip_h = true
	elif input_x > 0:
		sprite.flip_h = false
	
	if input_x != 0:
		velocity = velocity.move_toward(Vector2(input_x, 0) * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity, Vector2.UP)

func _input(event):
	if event.is_action_pressed("pickup"): # if pickup action occurs (press z on keyboard)
		if $PickupZone.items_in_range.size() > 0: # if there are items in range
			var pickup_item = $PickupZone.items_in_range.values()[0] # select the first item in range
			pickup_item.pick_up_item(self) # pick up the item
			$PickupZone.items_in_range.erase(pickup_item) # remove the item from in range
