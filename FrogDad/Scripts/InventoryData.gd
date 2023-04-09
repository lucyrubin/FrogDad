class_name InventoryData
extends Node
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

const SlotClass = preload("res://Scripts/Slot.gd")
const ItemClass = preload("res://Scripts/Item.gd")

var NUM_INVENTORY_SLOTS

var inventory = {}

func setup(slots_num, item_list):
	NUM_INVENTORY_SLOTS = slots_num
	inventory = item_list
	
func add_item_to_empty_slot(item: ItemClass, slot: SlotClass):
	inventory[slot.slot_index] = [item.item_name, item.item_quantity]


func remove_item(slot: SlotClass):
	inventory.erase(slot.slot_index) # delete from the inventory dictionary
	
func add_item_quantity(slot: SlotClass, quantity_to_add: int):
	inventory[slot.slot_index][1] += quantity_to_add
