extends Node2D


func _ready(): 
	# set the z-index of all objects to be based on the y position
	for object in $YSort.get_children():
		object.z_index = object.position.y - 100
