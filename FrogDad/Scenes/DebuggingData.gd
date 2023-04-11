extends CanvasLayer


func _process(delta):
	$ColorRect/VBoxContainer/FrogDadPosition.text = "Frog Dad Position: " + str(round(MasterScript.FrogDad.position.x)) + ", " +  str(round(MasterScript.FrogDad.position.y)) +  ", " + str(round(MasterScript.FrogDad.z_index))
	$ColorRect/VBoxContainer/CurrentQuestNumLabel.text = "Current Quest Number: " + str(MasterScript.currentQuestNum)
	$ColorRect/VBoxContainer/CurrentQuestArrayLabel.text = "Current Quest Array: " + str(MasterScript.currentQuestArray)
	$ColorRect/VBoxContainer/CameraPostion.text = "Camera Position: " + str(get_parent().get_camera_position())
	$ColorRect/VBoxContainer/FrogDadVisibility.text = "FrogDad Visibile: " + str(MasterScript.FrogDad.visible)
func _on_SkipIntroButton_pressed():
	
	MasterScript.currentQuestNum = 0
	SceneTransition.change_scene("res://Scenes/Main.tscn")
