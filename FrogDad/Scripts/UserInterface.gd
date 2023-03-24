extends CanvasLayer
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

func open_inventory():
	#$Inventory.visible = !$Inventory.visible # toggle inventory visibility
	$Inventory.initialize_inventory()
