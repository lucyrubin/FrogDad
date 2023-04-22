extends KinematicBody2D
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

export(String) var item_name
const MAX_SPEED = 600
const ACCELERATION = 500

var velocity = Vector2.ZERO
var player = null
var being_picked_up = false
var frog_dad_is_close = false

var direction_to_move # direction for item drop to move to get to the inventory leaf

onready var FrogDadNode = get_tree().get_root().find_node("FrogDad", true, false)

#Specifies which inventory item is added to
var FrogDadScene = load("res://Scenes/FrogDad.tscn")
export(NodePath) var FrogDad_path
onready var inventory_node = get_tree().get_root().find_node("Inventory", true, false)
onready var Camera2DNode = get_tree().get_root().find_node("Camera2D", true, false)

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
		velocity = velocity.move_toward(direction_to_move * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = Vector2(0,0)
	velocity=move_and_slide(velocity, Vector2.UP)

func pick_up_item(body):
	player = body
	being_picked_up = true
	direction_to_move = global_position.direction_to(Camera2DNode.get_camera_position() - Vector2(330,200))
	inventory_node.add_item(item_name, 1)
	$AnimationPlayer.play("fade")
	FrogDadNode.find_node("Quest", true, false).check_if_quest_fulfilled()
	

func get_sprite():
	return $Button


func _on_Button_pressed():
	
	if frog_dad_is_close and MasterScript.frog_dad_state == "":
		pick_up_item(self)


func _on_Button_mouse_entered():
	if frog_dad_is_close and MasterScript.frog_dad_state == "":
		$Button.texture_normal = load("res://Item Icons/" + item_name + "Hover.png")
		Input.set_custom_mouse_cursor(MasterScript.pointer)


func _on_Button_mouse_exited():
	$Button.texture_normal = load("res://Item Icons/" + item_name + ".png")
	Input.set_custom_mouse_cursor(MasterScript.hand)


func _on_Area2D_body_entered(_body):
	frog_dad_is_close = true


func _on_Area2D_body_exited(_body):
	frog_dad_is_close = false


func _on_FlyingTime_timeout(): # after three seconds, stop flying and fading and delete
	queue_free()
