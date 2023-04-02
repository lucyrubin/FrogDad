extends Area2D

var current_fram = 0
var num_frames = 2
onready var user_interface_node = get_tree().get_root().find_node("UserInterface",true, false)
onready var dresser_inventory_node = get_tree().get_root().find_node("DresserInventory",true, false)
onready var frogdad_node = get_tree().get_root().find_node("FrogDad",true, false)
func _ready():
	dresser_inventory_node.visible = false
	$AnimatedSprite.animation = "default"

func _on_Dresser_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		current_fram = (current_fram + 1) % num_frames
		$AnimatedSprite.set_frame(current_fram)
		if current_fram == 1:
			dresser_inventory_node.visible = true
			user_interface_node.visible = true
			frogdad_node.state = "Inventory"
		else:
			dresser_inventory_node.visible = false
			user_interface_node.visible = false
			frogdad_node.state = ""


func _on_Dresser_mouse_entered():
	$AnimatedSprite.animation = "hover"
	$AnimatedSprite.set_frame(current_fram)

func _on_Dresser_mouse_exited():
	$AnimatedSprite.animation = "default"
	$AnimatedSprite.set_frame(current_fram)
