extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$YSort/Dresser.z_index = $YSort/Dresser.position.y - 40
	$"YSort/TV Stand".z_index = $"YSort/TV Stand".position.y
	$YSort/Cradle.z_index = $YSort/Cradle.position.y - 40
	$"YSort/Bedside Table".z_index = $"YSort/Bedside Table".position.y - 40
	$"YSort/Bed".z_index = $YSort/Bed.position.y
	$YSort/Couch.z_index = $YSort/Couch.position.y
	$YSort/Table.z_index = $YSort/Table.position.y - 20
	$YSort/Chairs.z_index = $YSort/Chairs.position.y - 40
	
func _process(delta):	
	print($YSort/Dresser.z_index)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
