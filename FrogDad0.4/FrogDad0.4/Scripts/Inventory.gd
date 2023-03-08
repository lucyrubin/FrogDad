extends Node2D
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

const SlotClass = preload("res://Scripts/Slot.gd")
onready var inventory_slots = $GridContainer
var holding_item = null

func _ready():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
		slots[i].slot_index = i
	initialize_inventory()

func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton: 
		if event.button_index == BUTTON_LEFT && event.pressed: 
			if holding_item != null: # if currently holding an item
				if !slot.item: # if empty slot, place holding item to slot
					left_click_empty_slot(slot)
				else: # else, slot already has an item
					if holding_item.item_name != slot.item.item_name: # the items are different, so swap them
						left_click_different_item(event, slot)
					else: #same item, so try to merge them
						left_click_same_item(slot)
			elif slot.item: # not holding an item
				left_click_not_holding(slot)
				
# warning-ignore:unused_argument
func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()

func left_click_empty_slot(slot: SlotClass): # place holding item into the slot
	PlayerInventory.add_item_to_empty_slot(holding_item, slot)
	slot.putIntoSlot(holding_item)
	holding_item = null
	
func left_click_different_item(event: InputEvent, slot: SlotClass): # swap items
	PlayerInventory.remove_item(slot)
	PlayerInventory.add_item_to_empty_slot(holding_item, slot)
	var temp_item = slot.item
	slot.pickFromSlot()
	temp_item.global_position = event.global_position
	slot.putIntoSlot(holding_item)
	holding_item = temp_item
	
func left_click_same_item(slot: SlotClass):
	var stack_size = int(JsonData.item_data[slot.item.item_name]["StackSize"]) # get the stack size for the item
	var able_to_add = stack_size - slot.item.item_quantity # calculate how much more can fit in the slot
	if able_to_add >= holding_item.item_quantity: # if there is enough room to add all of the stuff you are holding
		PlayerInventory.add_item_quantity(slot, holding_item.item_quantity)
		slot.item.add_item_quantity(holding_item.item_quantity)
		holding_item.queue_free() # get rid of what you are holding
		holding_item = null
	else : # if there is not enough room in the slot for everything that you are holding
		PlayerInventory.add_item_quantity(slot, able_to_add)
		slot.item.add_item_quantity(able_to_add) # add as much as you can
		holding_item.decrease_item_quantity(able_to_add) # leave whatever is left over in your hand

func left_click_not_holding(slot: SlotClass): # remove item from slot and make it the holding_item
	PlayerInventory.remove_item(slot)
	holding_item = slot.item
	slot.pickFromSlot()
	holding_item.global_position = get_global_mouse_position()	
