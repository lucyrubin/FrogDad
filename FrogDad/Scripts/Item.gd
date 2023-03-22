extends Node2D
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

var item_name
var item_quantity
var label

func _ready(): 
	label = $Label
	#randomly pick what the item is, this is just for prototyping
	var rand_val = randi() % 2 # mod it by the number of items possible
	if rand_val == 0:
		item_name = "Fly"
	else :
		item_name = "Log"
	
	# pick the icon image
	$TextureRect.texture = load("res://Item Icons/" + item_name + ".png") 
	# get the stack size from the JSON dictionary
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	# pick a random item_quanitity (just for prototype purposes
	item_quantity = randi() % stack_size + 1
	
	# if the item can't be stacked, don't display the label
	if stack_size == 1:
		$Label.visible = false
	else: 
		$Label.text = String(item_quantity)

func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	$Label.text = String(item_quantity)

func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	$Label.text = String(item_quantity)

func set_item(nm, qt):
	item_name = nm
	item_quantity = qt
	$TextureRect.texture = load("res://Item Icons/" + item_name + ".png")
	
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	if stack_size == 1:
		$Label.visible = false
	else: 
		$Label.visible = true
		$Label.text = String(item_quantity)
