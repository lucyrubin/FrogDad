extends CanvasLayer

onready var pause_menu = $PauseMenu


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





func _on_PauseButton_pressed():
	pause_menu.show_menu()
#	$PauseButton.hide()
