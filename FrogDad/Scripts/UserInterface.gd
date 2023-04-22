extends CanvasLayer
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk
onready var FrogDad = get_tree().get_root().find_node("FrogDad", true, false)
onready var ToggleInventoryButton = get_tree().get_root().find_node("ToggleInventoryButton", true, false)
var mouse_in_inventory = false

func _ready():
	visible = true
	
	
func open_inventory():
	$Inventory.initialize_inventory()
	$Inventory.inventory_open = true
	$Inventory.visible = true
	MasterScript.frog_dad_state = "inventory"
	FrogDad.get_node("AnimatedSprite").stop()

func _on_ToggleInventoryButton_pressed():
	if MasterScript.frog_dad_state == "":
		$DarkBackground.visible = true
		$Inventory/AnimationPlayer.current_animation = "swoosh_in"
		$Inventory/AnimationPlayer.play()
		open_inventory()


func _on_DarkBackground_gui_input(event):
	if event is InputEventMouseButton: 
		if event.button_index == BUTTON_LEFT && event.pressed: 
			MasterScript.frog_dad_state = ""
			for child in get_children():
				child.visible = false
			FrogDad.find_node("Quest",true, false).visible = false
			FrogDad.find_node("Quest",true, false).close_quest()

