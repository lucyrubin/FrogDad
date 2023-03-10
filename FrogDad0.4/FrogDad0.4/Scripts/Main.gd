extends Node2D

const ItemDropClass = preload("res://Scripts/ItemDrop.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$FrogDad.z_index = ($FrogDad.position.y) # these two lines handle layers to that things that are higher on the screen are 
	$Baby.z_index = $Baby.position.y - 60# behind things lower on the screen
	

func toggle_dialogue_box_visibility():
	$FrogDad/DialogueBox.visible = !$FrogDad/DialogueBox.visible

func _input(event):
	if event.is_action_pressed("talk")&&  $Baby/Speech.visible && !$FrogDad/DialogueBox.visible: # when A is pressed, open the dialogue box
		toggle_dialogue_box_visibility()
		$FrogDad.state = "dialogue"
		$FrogDad/AnimatedSprite.stop()
		$Baby/Speech.visible = false
		#$Speech/Timer.start()
	if event.is_action_pressed("close_dialogue") && $FrogDad/DialogueBox.visible: # when Enter is pressed, close the dialogue box
		toggle_dialogue_box_visibility()
		$FrogDad.state = ""
	if event.is_action_pressed("inventory") && $FrogDad.state == "":
		$FrogDad/UserInterface.open_inventory()
		$FrogDad/UserInterface.visible = true
		$FrogDad.state = "inventory"
		$FrogDad/AnimatedSprite.stop()
	elif event.is_action_pressed("inventory") && $FrogDad.state == "inventory":
		$FrogDad/UserInterface.open_inventory()
		$FrogDad/UserInterface.visible = false
		$FrogDad.state = ""
		$FrogDad/AnimatedSprite.stop()
	if event.is_action_pressed("pickup"): # if pickup action occurs (press z on keyboard)
		if $FrogDad/PickupZone.items_in_range.size() > 0: # if there are items in range
			var pickup_item = $FrogDad/PickupZone.items_in_range.values()[0] # select the first item in range
			pickup_item.pick_up_item(self) # pick up the item
			$FrogDad/PickupZone.items_in_range.erase(pickup_item) # remove the item from in range
	if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT && event.pressed:
				if !(event.global_position.x < 300 && event.global_position.y < 270): # throw out if you aren't clicking on the inside ( these numbers correspond to where the inventory is positioned) 
					#TODO: coordinates should be abstracted ^ 
					var dropped_item = $FrogDad/UserInterface/Inventory.left_click_outside_inventory()
					drop_item(dropped_item)
					
func drop_item(item_drop : ItemDropClass):
	print($FrogDad/AnimatedSprite.global_position.x)
	item_drop.setup($FrogDad/AnimatedSprite.global_position.x + 100,$FrogDad/AnimatedSprite.global_position.y + 100,"log")
	add_child(item_drop)				
		

