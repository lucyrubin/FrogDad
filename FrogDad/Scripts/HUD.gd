extends CanvasLayer




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



