extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func new_quest(quest_text):
	$PopUpNotification/TextureRect/HBoxContainer/QuestNameLabel.text = quest_text
	$PopUpNotification.visible = true
	$PopUpNotification/AnimationPlayer.current_animation = "slide_in"
	$PopUpNotification/AnimationPlayer.play()

	$PopUpNotification/PopUpTimer.start()




func _on_PopUpTimer_timeout():

	$PopUpNotification/AnimationPlayer.current_animation = "fade_out"
	$PopUpNotification/AnimationPlayer.play()
	
	yield($PopUpNotification/AnimationPlayer,'animation_finished')
	

	$PopUpNotification/AnimationPlayer.stop()



func _on_MuteButton_pressed():
	BackgroundMusic.playing = !BackgroundMusic.playing
	if BackgroundMusic.playing:
		$MuteButton/Label.text = "Unmuted"
	else:
		$MuteButton/Label.text = "Muted"
