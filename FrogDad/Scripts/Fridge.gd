extends Area2D

var current_fram = 0
var num_frames = 2

onready var user_interface_node = get_tree().get_root().find_node("UserInterface",true, false)
onready var fridge_inventory_node = get_tree().get_root().find_node("FridgeInventory",true, false)
onready var frogdad_node = get_tree().get_root().find_node("FrogDad",true, false)
onready var 	DarkBackground = get_tree().get_root().find_node("DarkBackground", true, false)

func _ready():
	fridge_inventory_node.visible = false
	$AnimatedSprite.animation = "default"
	DarkBackground.connect("gui_input", self, "dark_background_input", []) 
	
func dark_background_input(event):
	if event is InputEventMouseButton: 
		if event.button_index == BUTTON_LEFT and event.pressed and current_fram == 1: 
			fridge_inventory_node.visible = false
			user_interface_node.visible = false
			frogdad_node.state = ""
			current_fram = (current_fram + 1) % num_frames
			$AnimatedSprite.set_frame(current_fram)

func _on_Fridge_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed and frogdad_node.state == "":
		current_fram = (current_fram + 1) % num_frames
		$AnimatedSprite.set_frame(current_fram)
		
		if current_fram == 1:
			fridge_inventory_node.visible = true
			user_interface_node.visible = true
			frogdad_node.state = "Inventory"
			user_interface_node.open_inventory()
			DarkBackground.visible = true
		
		else:
			fridge_inventory_node.visible = false
			user_interface_node.visible = false
			frogdad_node.state = ""
			DarkBackground.visible = false

func _on_Fridge_mouse_entered():
	if frogdad_node.state == "":
		$AnimatedSprite.animation = "hover"
		$AnimatedSprite.set_frame(current_fram)
	
func _on_Fridge_mouse_exited():
	if frogdad_node.state == "":
		$AnimatedSprite.animation = "default"
		$AnimatedSprite.set_frame(current_fram)
