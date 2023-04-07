extends Area2D
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

export(String) var item_name

var velocity = Vector2.ZERO
var player = null
var being_picked_up = false
var frog_dad_is_close = false

#Specifies which inventory item is added to
var FrogDadScene = load("res://Scenes/FrogDad.tscn")
export(NodePath) var FrogDad_path
onready var inventory_node = get_tree().get_root().find_node("Inventory", true, false)

func _ready():
	z_index = position.y #default setup
	if(item_name == null):
		item_name = "Log"
		
	$Button.texture_normal = load("res://Item Icons/" + item_name + ".png") 

func setup(xgiven, ygiven, name, inventory):
	
	global_position.x = xgiven 
	global_position.y = ygiven
	z_index = global_position.y

	item_name = name
	inventory_node = inventory

	$Button.texture_normal = load("res://Item Icons/" + item_name + ".png") 
	
func _physics_process(delta):
	if being_picked_up: # if it's not being picked up, apply gravity
		inventory_node.add_item(item_name, 1)
		queue_free()

func pick_up_item(body):
	player = body
	being_picked_up = true

func get_sprite():
	return $Button


func _on_Button_pressed():
	if frog_dad_is_close:
		pick_up_item(self)


func _on_Button_mouse_entered():
	if frog_dad_is_close:
		$Button.texture_normal = load("res://Item Icons/" + item_name + "Hover.png") 


func _on_Button_mouse_exited():
	$Button.texture_normal = load("res://Item Icons/" + item_name + ".png") 
	

func _on_ItemDrop_body_entered(body):
	frog_dad_is_close = true


func _on_ItemDrop_body_exited(body):
	frog_dad_is_close = false
