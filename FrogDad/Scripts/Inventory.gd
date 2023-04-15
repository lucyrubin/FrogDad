extends Node2D
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk
const SlotClass = preload("res://Scripts/Slot.gd")

export (Dictionary) var item_list
export (String) var inventory_type

onready var inventory_slots = $GridContainer
var ItemDropClass = preload("res://Scenes/ItemDrop.tscn")
var inventory_open = false
var mouse_in_inventory = false
var inventory_data = InventoryData.new()
var FrogDad
onready var user_interface_node = get_tree().get_root().find_node("UserInterface",true, false)
onready var dresser_inventory_node = get_tree().get_root().find_node("DresserInventory",true, false)
onready var frogdad_node = get_tree().get_root().find_node("FrogDad",true, false)

func _ready():
	var slots = inventory_slots.get_children()
		
	inventory_data.setup(slots.size(), item_list)
	
	# allow slots to be clicked on and give them each an index
	for i in range(slots.size()):
		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]]) 
		slots[i].slot_index = i
	initialize_inventory()
	
	FrogDad = get_tree().get_root().find_node("FrogDad", true, false)

func initialize_inventory():
	
	var slots = inventory_slots.get_children()
	
	for i in range(slots.size()):
		# if there is something in the slot, initialize the item 
		if inventory_data.inventory.has(i) and inventory_data.inventory[i][1] > 0: 
			slots[i].initialize_item(inventory_data.inventory[i][0], inventory_data.inventory[i][1])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton: 
		if event.button_index == BUTTON_LEFT && event.pressed: 
			if FrogDad.holding_item != null: # if currently holding an item
				if !slot.item: # if empty slot, place holding item to slot
					left_click_empty_slot(slot)
				else: # else, slot already has an item
					if FrogDad.holding_item.item_name != slot.item.item_name: # the items are different, so swap them
						left_click_different_item(event, slot)
					else: #same item, so try to merge them
						left_click_same_item(slot)
			elif slot.item: # not holding an item
				left_click_not_holding(slot)


func _input(_event):
	# make the item that is being held follow the mouse
	if FrogDad.holding_item:
		FrogDad.holding_item.position = get_global_mouse_position()  -  Vector2(130,55)
		FrogDad.holding_item.z_index = 4090
	
		

func left_click_empty_slot(slot: SlotClass): # place holding item into the slot
	inventory_data.add_item_to_empty_slot(FrogDad.holding_item, slot)
	slot.put_into_slot(FrogDad.holding_item)
	FrogDad.holding_item = null
	
func left_click_different_item(event: InputEvent, slot: SlotClass): # swap items
	inventory_data.remove_item(slot)
	inventory_data.add_item_to_empty_slot(FrogDad.holding_item, slot)
	var temp_item = slot.item
	slot.pick_from_slot()
	temp_item.global_position = event.global_position -  Vector2(130,55)
	slot.put_into_slot(FrogDad.holding_item)
	FrogDad.holding_item = temp_item 
	
func left_click_same_item(slot: SlotClass):
	var stack_size = int(JsonData.item_data[slot.item.item_name]["StackSize"]) # get the stack size for the item
	var able_to_add = stack_size - slot.item.item_quantity # calculate how much more can fit in the slot
	if able_to_add >= FrogDad.holding_item.item_quantity: # if there is enough room to add all of the stuff you are holding
		inventory_data.add_item_quantity(slot, FrogDad.holding_item.item_quantity)
		slot.item.add_item_quantity(FrogDad.holding_item.item_quantity)
		FrogDad.holding_item.queue_free() # get rid of what you are holding
		FrogDad.holding_item = null
	else : # if there is not enough room in the slot for everything that you are holding
		inventory_data.add_item_quantity(slot, able_to_add)
		slot.item.add_item_quantity(able_to_add) # add as much as you can
		FrogDad.holding_item.decrease_item_quantity(able_to_add) # leave whatever is left over in your hand

func left_click_not_holding(slot: SlotClass): # remove item from slot and make it the FrogDad.holding_item
	inventory_data.remove_item(slot)
	FrogDad.holding_item = slot.item
	slot.pick_from_slot()
	FrogDad.holding_item.position = get_global_mouse_position() -  Vector2(130,55)

# Used from ItemDrop
func add_item(item_name, item_quantity):
	for item in inventory_data.inventory:
		if inventory_data.inventory[item][0] == item_name:
			var stack_size = int(JsonData.item_data[item_name]["StackSize"]) # get stack size from json data
			var able_to_add = stack_size - inventory_data.inventory[item][1] # how much room is left in the slot
			if able_to_add >= item_quantity: # if there is enough room, add everything
				inventory_data.inventory[item][1] += item_quantity
				update_slot_visual(item, inventory_data.inventory[item][0], inventory_data.inventory[item][1])
				return
			else:
				inventory_data.inventory[item][1] += able_to_add # add what we can
				update_slot_visual(item, inventory_data.inventory[item][0], inventory_data.inventory[item][1])
				item_quantity = item_quantity - able_to_add # subtract that from item_quantity
					
	# item doesn't exist in inventory yet, so add it to an empty slot
	for i in range(inventory_data.NUM_INVENTORY_SLOTS):
		if inventory_data.inventory.has(i) == false:
			inventory_data.inventory[i] = [item_name, item_quantity]
			update_slot_visual(i, inventory_data.inventory[i][0], inventory_data.inventory[i][1])
			return
			
func update_slot_visual(slot_index, item_name, new_quantity):
	var slot = get_node("GridContainer/Slot" + str(slot_index + 1))
	if new_quantity <= 0:
		print("emptying")
		slot.empty_slot()
	elif slot.item != null:
		slot.item.set_item(item_name, new_quantity)
	else:
		slot.initialize_item(item_name, new_quantity)
		


func removeItems(numItems, itemType):
	for item in inventory_data.inventory:
		if inventory_data.inventory[item][0] == itemType:
			print("found match: ", itemType)
			inventory_data.inventory[item][1] -= numItems
			print("subtracting ", numItems)
			print("updating: ", item , ": " , inventory_data.inventory[item][0] ,' ' , inventory_data.inventory[item][1])
			if inventory_data.inventory[item][1] <= 0:
				inventory_data.inventory.erase(item)
				print("erase")
				update_slot_visual(item, itemType, 0)
			else: 
				update_slot_visual(item, inventory_data.inventory[item][0], inventory_data.inventory[item][1])
				
			

### drop is not being used right now
func drop():
	if FrogDad.holding_item: 
		var dropped_item = ItemDropClass.instance()
		var quantity = FrogDad.holding_item.item_quantity - 1
		FrogDad.holding_item.item_quantity = quantity
		FrogDad.holding_item.label.text = str(quantity)
		dropped_item.item_name = FrogDad.holding_item.item_name
		if quantity == 0:
			FrogDad.holding_item.queue_free()
			#FrogDad.holding_item = null
		return dropped_item

func _on_TextureRect_mouse_entered():
	mouse_in_inventory = true;

func _on_TextureRect_mouse_exited():
	mouse_in_inventory = false;
