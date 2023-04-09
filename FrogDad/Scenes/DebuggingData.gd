extends CanvasLayer

onready var FrogDad = get_tree().get_root().find_node("FrogDad", true, false)
func _process(delta):
	$ColorRect/VBoxContainer/FrogDadPosition.text = "Frog Dad Position: " + str(round(FrogDad.position.x)) + ", " +  str(round(FrogDad.position.y)) +  ", " + str(round(FrogDad.z_index))
	$ColorRect/VBoxContainer/CurrentQuestNumLabel.text = "Current Quest Number: " + str(MasterScript.currentQuestNum)
	$ColorRect/VBoxContainer/CurrentQuestArrayLabel.text = "Current Quest Array: " + str(MasterScript.currentQuestArray)
	$ColorRect/VBoxContainer/CameraPostion.text = "Camera Position: " + str(get_parent().get_camera_position())

func _on_SkipIntroButton_pressed():
	
	MasterScript.currentQuestNum = 0
	SceneTransition.change_scene("res://Scenes/Main.tscn")