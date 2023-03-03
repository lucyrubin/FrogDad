extends Node
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk
const SlotClass = preload("res://Slot.gd")
const ItemClass = preload("res://Item.gd")
const NUM_INVENTORY_SLOTS = 20

var inventory = {
	0: ["Fly", 1], # slot_index: [item_name, item_quantity]
	1: ["Log", 98]
}

func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			var stack_size = int(JsonData.item_data[item_name]["StackSize"]) # get stack size from json data
			var able_to_add = stack_size - inventory[item][1] # how much room is left in the slot
			if able_to_add >= item_quantity: # if there is enough room, add everything
				inventory[item][1] += item_quantity
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				return
			else: 
				inventory[item][1] += able_to_add # add what we can
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				item_quantity = item_quantity - able_to_add # subtract that from item_quantity
					
	# item doesn't exist in inventory yet, so add it to an empty slot
	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			update_slot_visual(i, inventory[i][0], inventory[i][1])
			return
			
func update_slot_visual(slot_index, item_name, new_quantity):
	var slot = get_tree().root.get_node("/root/World/UserInterface/Inventory/GridContainer/Slot" + str(slot_index + 1))
	if slot.item != null:
		slot.item.set_item(item_name, new_quantity)
	else: 
		slot.initialize_item(item_name, new_quantity)
func add_item_to_empty_slot(item: ItemClass, slot: SlotClass):
	inventory[slot.slot_index] = [item.item_name, item.item_quantity]

func remove_item(slot: SlotClass):
	inventory.erase(slot.slot_index) # delete from the inventory dictionary
	
func add_item_quantity(slot: SlotClass, quantity_to_add: int):
	inventory[slot.slot_index][1] += quantity_to_add 
