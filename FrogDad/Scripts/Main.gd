extends Node2D

const ItemDropClass = preload("res://Scripts/ItemDrop.gd")
const ItemDropScene = preload("res://Scenes/ItemDrop.tscn")

func _ready():
	if MasterScript.enter_home:
		$FrogDad.position = $EnterHome.position
		MasterScript.enter_home = false
	if MasterScript.findBabies:
		$FrogDad.position = $EnterHome.position
		MasterScript.findBabies = false

func _process(delta):
	$FrogDad.z_index = ($FrogDad.position.y) # these two lines handle layers to that things that are higher on the screen are 
	#$BabyGertrude.z_index = $BabyGertrude.position.y - 60# behind things lower on the screen
	#NEEDS TO BE UNCOMMENTED
func _input(event):
	pass
#	if event.is_action_pressed("talk")&&  $BabyGertrude/Speech.visible && !$FrogDad/DialogueBox.visible: # when A is pressed, open the dialogue box
#		toggle_dialogue_box_visibility()
#		$FrogDad.state = "dialogue"
#		$FrogDad/AnimatedSprite.stop()
#		#$BabyGertrude/Speech.visible = false
#	if event.is_action_pressed("close_dialogue") && $FrogDad/DialogueBox.visible: # when Enter is pressed, close the dialogue box
#		toggle_dialogue_box_visibility()
#		$FrogDad.state = ""
#	if event.is_action_pressed("inventory") && $FrogDad.state == "": # if not doing anything, and inventory is pressed, open the inventory
#		$FrogDad/UserInterface.open_inventory()
#		$FrogDad/UserInterface.visible = true
#		$FrogDad/UserInterface/Inventory.inventory_open = true
#		$FrogDad.state = "inventory"
#		$FrogDad/AnimatedSprite.stop()
#	elif event.is_action_pressed("inventory") && $FrogDad.state == "inventory":
#		$FrogDad/UserInterface.open_inventory()
#		$FrogDad/UserInterface.visible = false
#		$FrogDad/UserInterface/Inventory.inventory_open = false
#		$FrogDad.state = ""
#		$FrogDad/AnimatedSprite.stop()
#	if event.is_action_pressed("pickup"): # if pickup action occurs (press z on keyboard)
#		if $FrogDad/PickupZone.items_in_range.size() > 0: # if there are items in range
#			var pickup_item = $FrogDad/PickupZone.items_in_range.values()[0] # select the first item in range
#			pickup_item.pick_up_item(self) # pick up the item
#			$FrogDad/PickupZone.items_in_range.erase(pickup_item) # remove the item from in range
#	if event.is_action_pressed("drop") \
#	&& $FrogDad/UserInterface/Inventory.inventory_open == true \
#	&& $FrogDad.holding_item != null:
#		var dropped_item = $FrogDad/UserInterface/Inventory.drop()
#		#drop_item(dropped_item) this is commented out because we are just deleting the stuff for right now

func drop_item(item_drop : ItemDropClass):
	item_drop.setup($FrogDad/AnimatedSprite.global_position.x + 100,$FrogDad/AnimatedSprite.global_position.y + 100,item_drop.item_name, $FrogDad/UserInterface/Inventory )
	add_child(item_drop)	


func add_item_drop(type, x, y):
	var drop = ItemDropScene.instance()
	drop.setup(x,y,type, $FrogDad/UserInterface/Inventory)
	add_child(drop)



