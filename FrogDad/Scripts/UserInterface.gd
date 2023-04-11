extends CanvasLayer
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

onready var ToggleInventoryButton = get_tree().get_root().find_node("ToggleInventoryButton", true, false)
var mouse_in_inventory = false

onready var user_interface_node = get_tree().get_root().find_node("UserInterface",true, false)
onready var dresser_inventory_node = get_tree().get_root().find_node("DresserInventory",true, false)


func open_inventory():
	$Inventory.initialize_inventory()
	visible = true
	$Inventory.inventory_open = true
	$Inventory.visible = true
	MasterScript.FrogDad.state = "inventory"
	MasterScript.FrogDad.get_node("AnimatedSprite").stop()

func _on_ToggleInventoryButton_pressed():
	ToggleInventoryButton.visible = false
	$DarkBackground.visible = true
	open_inventory()
	
func _input(event):
	if event.is_action_pressed("escape"): 
		if $Inventory.visible: # close inventory
			$Inventory.inventory_open = false
			visible = false
			$Inventory.visible = false
			MasterScript.FrogDad.state = ""
			MasterScript.FrogDad.get_node("AnimatedSprite").play()
			ToggleInventoryButton.visible = true
			$DarkBackground.visible = false
		if !ToggleInventoryButton.visible:
			ToggleInventoryButton.visible = true
			
	
func _on_TextureRect_mouse_entered():
	mouse_in_inventory = true


func _on_TextureRect_mouse_exited():
	mouse_in_inventory = false
