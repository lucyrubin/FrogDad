extends Area2D

var current_fram = 0
var num_frames = 2

onready var user_interface_node = get_tree().get_root().find_node("UserInterface",true, false)
onready var table_inventory_node = get_tree().get_root().find_node("SideTableInventory",true, false)
onready var frogdad_node = get_tree().get_root().find_node("FrogDad",true, false)

func _ready():
	table_inventory_node.visible = false
	$AnimatedSprite.animation = "default"
	
func _input(event):
	# if escape is pressed and open, then close it all
	if event.is_action_pressed("escape") and current_fram == 1:
		table_inventory_node.visible = false
		user_interface_node.visible = false
		frogdad_node.state = ""
		current_fram = (current_fram + 1) % num_frames
		$AnimatedSprite.set_frame(current_fram)

func _on_Side_Table_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		current_fram = (current_fram + 1) % num_frames
		$AnimatedSprite.set_frame(current_fram)
		if current_fram == 1:
			table_inventory_node.visible = true
			user_interface_node.visible = true
			frogdad_node.state = "Inventory"
			user_interface_node.open_inventory()
			var DarkBackground = get_tree().get_root().find_node("DarkBackground", true, false)
			DarkBackground.visible = true
		else:
			table_inventory_node.visible = false
			user_interface_node.visible = false
			frogdad_node.state = ""
			var DarkBackground = get_tree().get_root().find_node("DarkBackground", true, false)
			DarkBackground.visible = false

func _on_Side_Table_area_entered(area):
	$AnimatedSprite.animation = "hover"
	$AnimatedSprite.set_frame(current_fram)

func _on_Side_Table_area_exited(area):
	$AnimatedSprite.animation = "default"
	$AnimatedSprite.set_frame(current_fram)

func _on_Side_Table_mouse_entered():
	$AnimatedSprite.animation = "hover"
	$AnimatedSprite.set_frame(current_fram)

func _on_Side_Table_mouse_exited():
	$AnimatedSprite.animation = "default"
	$AnimatedSprite.set_frame(current_fram)
