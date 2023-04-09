class_name Forest_Entrance

extends Area2D

export (PackedScene) var target_scene = load("res://Scenes/Forest.tscn")

func go_in_forest():
	MasterScript.enter_forest = true
	var ERR = get_tree().change_scene_to(target_scene)
	if ERR != OK:
		print("something failed in the door scene")


func _on_ForestEntrance_area_entered(area):
	go_in_forest()
