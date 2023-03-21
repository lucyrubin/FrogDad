extends KinematicBody2D

#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

const ACCELERATION = 460
const MAX_SPEED = 225
var velocity = Vector2.ZERO
var item_name

var player = null
var being_picked_up = false

export(NodePath) var inventory_path
onready var inventory_node = get_node(inventory_path)

func _ready():
	#$Sprite.z_index = $Sprite.position.y #default setup
	if(item_name == null):
		item_name = "Log"
	$Sprite.texture = load("res://Item Icons/" + item_name + ".png") 
	

func setup(xgiven, ygiven, name):
	
	global_position.x = xgiven 
	global_position.y = ygiven
	z_index = global_position.y

	item_name = name
	$Sprite.texture = load("res://Item Icons/" + item_name + ".png") 

	

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
#			Inventory.add_item(item_name, 1)
#			queue_free()
		inventory_node.add_item(item_name, 1)
		queue_free()
	#velocity = move_and_slide(velocity, Vector2.UP)

func pick_up_item(body):
	player = body
	being_picked_up = true

func get_sprite():
	return $Sprite
