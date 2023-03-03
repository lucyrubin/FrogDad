extends Area2D
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk
func _ready():
	pass # Replace with function body.




var items_in_range = {} # a dictionary

func _on_PickupZone_body_entered(body):
	items_in_range[body] = body # add body to items_in_range when the player touches it


func _on_PickupZone_body_exited(body): # when the player isn't touching it, erase it from in-range
	if items_in_range.has(body):
		items_in_range.erase(body)
