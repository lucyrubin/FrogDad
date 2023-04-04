extends CanvasLayer
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk
onready var FrogDad = get_tree().get_root().find_node("FrogDad", true, false)
onready var ToggleInventoryButton = get_tree().get_root().find_node("ToggleInventoryButton", true, false)

func open_inventory():
	#$Inventory.visible = !$Inventory.visible # toggle inventory visibility
	$Inventory.initialize_inventory()


func _on_ToggleInventoryButton_pressed():
	visible = true
	$Inventory.inventory_open = true
	$Inventory.visible = true
	FrogDad.state = "inventory"
	FrogDad.get_node("AnimatedSprite").stop()
	ToggleInventoryButton.visible = false
	open_inventory()
	
func _input(event):
	if event.is_action_pressed("escape") and !ToggleInventoryButton.visible:
		#print("hi")
		$Inventory.inventory_open = false
		visible = false
		$Inventory.visible = false
		FrogDad.state = ""
		FrogDad.get_node("AnimatedSprite").play()
		ToggleInventoryButton.visible = true
		
