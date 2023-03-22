extends CanvasLayer
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk
const FrogDadClass = preload("res://Scripts/FrogDad.gd")
func _input(event):
	if event.is_action_pressed("inventory") && FrogDadClass.state == "":
		$Inventory.visible = !$Inventory.visible # toggle inventory visibility
		$Inventory.initialize_inventory()

# Called when the node enters the scene tree for the first time.
func _ready(): #yuh
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
