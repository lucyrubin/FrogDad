class_name InventoryData
extends Node
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk
const SlotClass = preload("res://Scripts/Slot.gd")
const ItemClass = preload("res://Scripts/Item.gd")
const NUM_INVENTORY_SLOTS = 20

var inventory = {
	0: ["Fly", 1], # slot_index: [item_name, item_quantity]
	1: ["Log", 98],
	2: ["Cloth", 4]
}

func add_item_to_empty_slot(item: ItemClass, slot: SlotClass):
	inventory[slot.slot_index] = [item.item_name, item.item_quantity]
	print(inventory)

func remove_item(slot: SlotClass):
	inventory.erase(slot.slot_index) # delete from the inventory dictionary
	
func add_item_quantity(slot: SlotClass, quantity_to_add: int):
	inventory[slot.slot_index][1] += quantity_to_add
