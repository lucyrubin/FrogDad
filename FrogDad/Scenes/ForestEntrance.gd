class_name Forest_Entrance

extends Area2D

export (PackedScene) var target_scene = load("res://Scenes/Forest.tscn")

var in_forest

func _input(event):
	if event.is_action_pressed("open"):
		if !target_scene:
			print("no scene in this door")
		go_in_forest()

func go_in_forest():
	in_forest = true
	var ERR = get_tree().change_scene_to(target_scene)
	if ERR != OK:
		print("something failed in the door scene")
