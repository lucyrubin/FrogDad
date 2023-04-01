extends Control

var MainScene = "res://Scenes/Main.tscn"

func _on_StartButton_pressed():
	SceneTransition.change_scene(MainScene)

func _on_QuitButton_pressed():
	get_tree().quit()
