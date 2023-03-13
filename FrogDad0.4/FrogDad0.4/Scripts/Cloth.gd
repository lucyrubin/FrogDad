extends KinematicBody2D

#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

const ACCELERATION = 460
const MAX_SPEED = 225
var velocity = Vector2.ZERO
var item_name

var player = null
var being_picked_up = false

func _ready():
	$AnimatedSprite.z_index = $AnimatedSprite.position.y
	item_name = "Cloth"

func _physics_process(delta):
	if being_picked_up == false: # if it's not being picked up, apply gravity
		pass
		#velocity = velocity.move_toward(Vector2(0, MAX_SPEED), ACCELERATION * delta)
	else: # if it is being picked up, move towards the player
#		var direction = global_position.direction_to(player.global_position) # direction to player
#		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta) # apply velocity to go towards the player
#
#		var distance = global_position.distance_to(player.global_position)
#		if distance < 4: # destroy it once it is close enough to the player
#			PlayerInventory.add_item(item_name, 1)
#			queue_free()
		PlayerInventory.add_item(item_name, 1)
		queue_free()
	#velocity = move_and_slide(velocity, Vector2.UP)

func pick_up_item(body):
	player = body
	being_picked_up = true
