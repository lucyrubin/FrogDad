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
	#$AnimatedSprite.z_index = $AnimatedSprite.position.y
	item_name = "Cloth"

func _physics_process(delta):
	if being_picked_up == false: # if it's not being picked up, apply gravity
		pass
	else:
		inventory_node.add_item(item_name, 1)
		queue_free()
	#velocity = move_and_slide(velocity, Vector2.UP)

func pick_up_item(body):
	player = body
	being_picked_up = true
