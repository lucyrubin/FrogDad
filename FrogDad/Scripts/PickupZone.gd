extends Area2D
const ItemDropClass = preload("res://Scripts/ItemDrop.gd")
const LogDropClass = preload("res://Scripts/LogDrop.gd")
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk


var items_in_range = {} # a dictionary

func _on_PickupZone_body_entered(body):

	if body is ItemDropClass: 
		
		items_in_range[body] = body # add body to items_in_range when the player touches it


func _on_PickupZone_body_exited(body): # when the player isn't touching it, erase it from in-range
	if body is ItemDropClass:
		if items_in_range.has(body):
			items_in_range.erase(body)
