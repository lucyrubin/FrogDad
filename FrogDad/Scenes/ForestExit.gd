extends Area2D

export (PackedScene) var target_scene = load("res://Scenes/Outdoors.tscn")

func _input(event):
	if event.is_action_pressed("open"):
		if !target_scene:
			print("no scene in this door")
		leave_forest()

func leave_forest():
	var ERR = get_tree().change_scene_to(target_scene)
	if ERR != OK:
		print("something failed in the door scene")
