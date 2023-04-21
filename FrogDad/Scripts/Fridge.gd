extends Area2D

var current_fram = 0
var num_frames = 2

onready var user_interface_node = get_tree().get_root().find_node("UserInterface",true, false)
onready var fridge_inventory_node = get_tree().get_root().find_node("FridgeInventory",true, false)
onready var FrogDad = get_tree().get_root().find_node("FrogDad", true, false)
onready var 	DarkBackground = get_tree().get_root().find_node("DarkBackground", true, false)

func _ready():
	fridge_inventory_node.visible = false
	$AnimatedSprite.animation = "default"
	DarkBackground.connect("gui_input", self, "dark_background_input", []) 

func dark_background_input(event):
	if event is InputEventMouseButton: 
		if event.button_index == BUTTON_LEFT and event.pressed: 
			current_fram = 0
			$AnimatedSprite.animation = "default"
			$AnimatedSprite.set_frame(current_fram)
			
func _on_Fridge_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed and FrogDad.state == "":
		
		current_fram = (current_fram + 1) % num_frames
		$AnimatedSprite.set_frame(current_fram)
		
		if current_fram == 1:
			fridge_inventory_node.visible = true
			user_interface_node.visible = true
			FrogDad.state = "Inventory"
			user_interface_node.open_inventory()
			DarkBackground.visible = true

func _on_Fridge_mouse_entered():
	if FrogDad.state == "":
		$AnimatedSprite.animation = "hover"
		$AnimatedSprite.set_frame(current_fram)
	
func _on_Fridge_mouse_exited():
	if FrogDad.state == "":
		$AnimatedSprite.animation = "default"
		$AnimatedSprite.set_frame(current_fram)

func _on_Fridge_area_entered(area):
	if FrogDad.state == "":
		$Interact.visible = true
		$Interact/AnimationPlayer.play("Float")

func _on_Fridge_area_exited(area):
	if FrogDad.state == "":
		$Interact.visible = false
		$Interact/AnimationPlayer.stop()
