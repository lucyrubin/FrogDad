extends Area2D

export (PackedScene) var target_scene = load("res://Scenes/Outdoors.tscn")

var forest_exit_area = false

func _input(event):
	if event.is_action_pressed("open") && forest_exit_area:
		if !target_scene:
			print("no scene in this door")
		leave_forest()

func leave_forest():
	MasterScript.exit_forest = true
	var ERR = get_tree().change_scene_to(target_scene)
	if ERR != OK:
		print("something failed in the door scene")


func _on_ForestExit_area_entered(area):
	forest_exit_area = true

func _on_ForestExit_area_exited(area):
	forest_exit_area = false
