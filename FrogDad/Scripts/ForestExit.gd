extends Area2D

export (PackedScene) var target_scene = load("res://Scenes/Outdoors.tscn")

func leave_forest():
	MasterScript.exit_forest = true
	SceneTransition.change_scene("res://Scenes/Outdoors.tscn")


func _on_ForestExit_area_entered(area):
	leave_forest()
