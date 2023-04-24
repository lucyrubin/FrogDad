class_name Forest_Entrance

extends Area2D

export (PackedScene) var target_scene = load("res://Scenes/Forest.tscn")

func go_in_forest():
	MasterScript.enter_forest = true
	SceneTransition.change_scene("res://Scenes/Forest.tscn")

func _on_ForestEntrance_area_entered(_area):
	go_in_forest()
