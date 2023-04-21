extends CanvasLayer
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk
onready var FrogDad = get_tree().get_root().find_node("FrogDad", true, false)
onready var ToggleInventoryButton = get_tree().get_root().find_node("ToggleInventoryButton", true, false)
var mouse_in_inventory = false

func _ready():
	visible = true
	$DarkBackground.connect("gui_input", self, "dark_background_input", []) 

func dark_background_input(event):
	if event is InputEventMouseButton: 
		if event.button_index == BUTTON_LEFT && event.pressed: 
			FrogDad.state = ""
			for child in get_children():
				child.visible = false
			FrogDad.find_node("Quest",true, false).visible = false
			FrogDad.find_node("Quest",true, false).close_quest()

	
func open_inventory():
	$Inventory.initialize_inventory()
	$Inventory.inventory_open = true
	$Inventory.visible = true
	FrogDad.state = "inventory"
	FrogDad.get_node("AnimatedSprite").stop()

func _on_ToggleInventoryButton_pressed():
	#ToggleInventoryButton.visible = false
	$DarkBackground.visible = true
	$Inventory/AnimationPlayer.current_animation = "swoosh_in"
	$Inventory/AnimationPlayer.play()
	open_inventory()
	
#func _input(event):
#	if event.is_action_pressed("escape"): 
#		if $Inventory.visible: # close inventory
#			$Inventory.inventory_open = false
#			visible = false
#			$Inventory.visible = false
#			FrogDad.state = ""
#			FrogDad.get_node("AnimatedSprite").play()
#			ToggleInventoryButton.visible = true
#			$DarkBackground.visible = false
#		if !ToggleInventoryButton.visible:
#			ToggleInventoryButton.visible = true
#


