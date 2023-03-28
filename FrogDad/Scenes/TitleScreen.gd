extends Control



var main_scene = "res://Scenes/Main.tscn"


func _on_StartButton_pressed():
	SceneTransition.change_scene(main_scene)
	
	

func _on_QuitButton_pressed():
	get_tree().quit()
