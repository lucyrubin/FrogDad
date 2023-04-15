extends Area2D

export (PackedScene) var target_scene = load("res://Scenes/Outdoors.tscn")

func leave_forest():
	MasterScript.exit_forest = true
	var ERR = get_tree().change_scene_to(target_scene)
	if ERR != OK:
		print("something failed in the door scene")


func _on_ForestExit_area_entered(area):
	leave_forest()
