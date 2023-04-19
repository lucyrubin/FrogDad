extends Area2D

var current_fram = 0
var num_frames = 2
onready var user_interface_node = get_tree().get_root().find_node("UserInterface",true, false)
onready var dresser_inventory_node = get_tree().get_root().find_node("DresserInventory",true, false)
onready var frogdad_node = get_tree().get_root().find_node("FrogDad",true, false)

func _ready():
	dresser_inventory_node.visible = false
	$AnimatedSprite.animation = "default"

func _on_Dresser_input_event(_viewport, event, _shape_idx):	
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed \
	and frogdad_node.state == "":
		current_fram = (current_fram + 1) % num_frames
		$AnimatedSprite.set_frame(current_fram)
		
		if current_fram == 1:
			dresser_inventory_node.visible = true
			user_interface_node.visible = true
			frogdad_node.state = "Inventory"
			user_interface_node.open_inventory()
			var DarkBackground = get_tree().get_root().find_node("DarkBackground", true, false)
			DarkBackground.visible = true
		
		else:
			dresser_inventory_node.visible = false
			user_interface_node.visible = false
			frogdad_node.state = ""
			var DarkBackground = get_tree().get_root().find_node("DarkBackground", true, false)
			DarkBackground.visible = false

func _input(event):
	# if escape is pressed and open, then close it all
	if event.is_action_pressed("escape") and current_fram == 1:
		dresser_inventory_node.visible = false
		user_interface_node.visible = false
		frogdad_node.state = ""
		current_fram = (current_fram + 1) % num_frames
		$AnimatedSprite.set_frame(current_fram)

func _on_Dresser_mouse_entered():
	if frogdad_node.state == "" and $Interact.visible == true:
		$AnimatedSprite.animation = "hover"
		$AnimatedSprite.set_frame(current_fram)

func _on_Dresser_mouse_exited():
	if frogdad_node.state == "" and $Interact.visible == false:
		$AnimatedSprite.animation = "default"
		$AnimatedSprite.set_frame(current_fram)

func _on_Dresser_area_entered(area):
	if frogdad_node.state == "":
		$Interact.visible = true
		
func _on_Dresser_area_exited(area):
	if frogdad_node.state == "":
		$Interact.visible = false
