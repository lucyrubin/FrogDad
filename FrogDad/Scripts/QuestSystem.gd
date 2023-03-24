extends Node2D

var frog_dad_inventory
var frog_dad_inventory_data
var swaddleQuest = false

func _ready():
	frog_dad_inventory = get_parent().get_node("Inventory")
	frog_dad_inventory_data = frog_dad_inventory.inventory_data
	swaddleQuest = true
	

func _process(delta):
	pass
	if swaddleQuest:
		var totalLog = 0
		for item in frog_dad_inventory_data.inventory:
			if frog_dad_inventory_data.inventory[item][0] == "Log":
				totalLog += frog_dad_inventory_data.inventory[item][1]
		
		$SingleQuest/Label.text = "Collect 100 logs: " + str(totalLog) + "/100" 
		#$SingleQuest/Label.text = "ignore this, i'm just using \n this for testing :) - lucy"
