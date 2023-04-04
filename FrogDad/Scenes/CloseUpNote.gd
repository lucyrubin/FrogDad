extends TextureRect

var FrogDad

func _ready():
	FrogDad = get_tree().get_root().find_node("FrogDad", true, false)
	
func _on_CloseButton_pressed():
	get_tree().get_root().find_node("CloseUpNote", true, false).visible = false
	## change scene to the cut scene of the eggs
	SceneTransition.change_scene("res://Scenes/FindBabiesCutScene.tscn")
	
	
	var toggleQuestButton = get_tree().get_root().find_node("ToggleQuestButton", true, false)
	toggleQuestButton.visible = true
	toggleQuestButton.blink() # need to write this method
	FrogDad.state = ""
	FrogDad.get_tree().get_root().find_node("Door", true, false).set_locked(false)
	MasterScript.currentQuestNum +=1
	
	
