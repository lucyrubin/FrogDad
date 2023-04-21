extends Control

var MainScene = "res://Scenes/Main.tscn"

func _ready():
	if BackgroundMusic.playing == false:
		BackgroundMusic.play()

func _on_StartButton_pressed():
	SceneTransition.change_scene(MainScene)

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_SkipIntroButton_pressed():
	MasterScript.currentQuestNum = 0
	SceneTransition.change_scene("res://Scenes/Main.tscn")


func _on_SkipIntroGoToJJ_pressed():
	MasterScript.currentQuestNum = 3
	SceneTransition.change_scene("res://Scenes/JimothyJohns.tscn")
