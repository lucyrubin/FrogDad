class_name Forest_Entrance

extends Area2D

export (PackedScene) var target_scene = load("res://Scenes/Forest.tscn")

var in_forest

func _input(event):
	if event.is_action_pressed("open"):
		if !target_scene:
			print("no scene in this door")
		if in_forest:
			go_in_forest()

func go_in_forest():
	MasterScript.enter_forest = true
	var ERR = get_tree().change_scene_to(target_scene)
	if ERR != OK:
		print("something failed in the door scene")


func _on_ForestEntrance_area_entered(area):
	in_forest = true


func _on_ForestEntrance_area_exited(area):
	in_forest = false
