extends Area2D

var current_fram = 0
var num_frames = 2

onready var user_interface_node = get_tree().get_root().find_node("UserInterface",true, false)
onready var table_inventory_node = get_tree().get_root().find_node("SideTableInventory",true, false)
onready var frogdad_node = get_tree().get_root().find_node("FrogDad",true, false)
onready 	var DarkBackground = get_tree().get_root().find_node("DarkBackground", true, false)

func _ready():
	table_inventory_node.visible = false
	$AnimatedSprite.animation = "default"
	DarkBackground.connect("gui_input", self, "dark_background_input", []) 

func dark_background_input(event):
	if event is InputEventMouseButton: 
		if event.button_index == BUTTON_LEFT and event.pressed: 
			current_fram = 0
			$AnimatedSprite.animation = "default"
			$AnimatedSprite.set_frame(current_fram)
			
func _on_Side_Table_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed and frogdad_node.state == "":
		current_fram = (current_fram + 1) % num_frames
		$AnimatedSprite.set_frame(current_fram)
		if current_fram == 1:
			table_inventory_node.visible = true
			user_interface_node.visible = true
			frogdad_node.state = "Inventory"
			user_interface_node.open_inventory()
			DarkBackground.visible = true

func _on_Side_Table_mouse_entered():
	if frogdad_node.state == "" and $Interact.visible == true:
		$AnimatedSprite.animation = "hover"
		$AnimatedSprite.set_frame(current_fram)
		Input.set_custom_mouse_cursor(MasterScript.pointer)

func _on_Side_Table_mouse_exited():
	if frogdad_node.state == "" and $Interact.visible == false:
		$AnimatedSprite.animation = "default"
		$AnimatedSprite.set_frame(current_fram)

func _on_Area2D_area_entered(area):
	if frogdad_node.state == "":
		$Interact.visible = true
		$Interact/AnimationPlayer.play("Float")

func _on_Area2D_area_exited(area):
	if frogdad_node.state == "":
		$Interact.visible = false
		$Interact/AnimationPlayer.stop()
		Input.set_custom_mouse_cursor(MasterScript.hand)
