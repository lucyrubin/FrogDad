extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$FrogDad.z_index = ($FrogDad.position.y) # these two lines handle layers to that things that are higher on the screen are 
	$Baby.z_index = -$Baby.position.y # behind things lower on the screen
	print($FrogDad/UserInterface/Inventory.position.x)

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

		
		
