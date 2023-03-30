extends KinematicBody2D

#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

var velocity = Vector2.ZERO
export(String) var item_name

var player = null
var being_picked_up = false

#Specifies which inventory item is added to
var FrogDadScene = load("res://Scenes/FrogDad.tscn")
export(NodePath) var frog_dad_path
#onready var inventory_node = get_node(frog_dad_path).getInventoryNode()
onready var inventory_node = get_parent().get_node("FrogDad/UserInterface/Inventory")
func _ready():
#	print(get_parent().get_node("FrogDad/UserInterface/Inventory"))
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

	$Sprite.texture = load("res://Item Icons/" + item_name + ".png") 
	
func _physics_process(delta):
	if being_picked_up: # if it's not being picked up, apply gravity
		inventory_node.add_item(item_name, 1)
		queue_free()

func pick_up_item(body):
	player = body
	being_picked_up = true

func get_sprite():
	return $Sprite
