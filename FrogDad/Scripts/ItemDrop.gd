extends KinematicBody2D

#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

const ACCELERATION = 460
const MAX_SPEED = 225
var velocity = Vector2.ZERO
export(String) var item_name

var player = null
var being_picked_up = false

#Specifies which inventory item is added to
export(NodePath) var inventory_path
onready var inventory_node = get_node(inventory_path)
#var inventory_node = load("res://Scripts/Inventory.gd")


func _ready():
	#$Sprite.z_index = $Sprite.position.y #default setup
	if(item_name == null):
		item_name = "Log"
	#$Sprite.texture = load("res://Item Icons/" + item_name + ".png") 
	

func setup(xgiven, ygiven, name, inventory):
	
	global_position.x = xgiven 
	global_position.y = ygiven
	z_index = global_position.y

	item_name = name
	inventory_node = inventory
	print(inventory_node)

	$Sprite.texture = load("res://Item Icons/" + item_name + ".png") 
	

	

func _physics_process(delta):
	if being_picked_up == false: # if it's not being picked up, apply gravity

		pass

	else: 
		print("pickup")
		print(inventory_node)
		inventory_node.add_item(item_name, 1)
		queue_free()


func pick_up_item(body):
	player = body
	being_picked_up = true

func get_sprite():
	return $Sprite
