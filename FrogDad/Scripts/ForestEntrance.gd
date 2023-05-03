class_name Forest_Entrance

extends Area2D

export (PackedScene) var target_scene = load("res://Scenes/Forest.tscn")

func go_in_forest():
	MasterScript.enter_forest = true
	SceneTransition.change_scene("res://Scenes/Forest.tscn")
	
func go_in_lettuce_garden():
	MasterScript.enter_lettuce_garden = true
	SceneTransition.change_scene("res://Scenes/LettuceForest.tscn")

func go_outside():
	MasterScript.exit_lettuce_garden = true
	SceneTransition.change_scene("res://Scenes/Outdoors.tscn")

func _on_ForestEntrance_area_entered(_area):
	go_in_forest()

func _on_LettuceGardenEnterance_area_entered(area):
	go_in_lettuce_garden()

func _on_LettuceExit_area_entered(area):
	go_outside()
