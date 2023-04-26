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
	MasterScript.currentQuestNum = 2
	MasterScript.currentQuestArray = [MasterScript.questDictionary[MasterScript.currentQuestNum]]
	SceneTransition.change_scene("res://Scenes/JimothyJohns.tscn")


func _on_StartButton_mouse_entered():
	Input.set_custom_mouse_cursor(MasterScript.pointer)


func _on_StartButton_mouse_exited():
	Input.set_custom_mouse_cursor(MasterScript.hand)


func _on_QuitButton_mouse_entered():
	Input.set_custom_mouse_cursor(MasterScript.pointer)


func _on_QuitButton_mouse_exited():
	Input.set_custom_mouse_cursor(MasterScript.hand)
