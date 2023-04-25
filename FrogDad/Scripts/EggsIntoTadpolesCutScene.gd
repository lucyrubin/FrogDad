extends Node2D


func _on_Timer_timeout():
	$Gertrude.visible = true
	$Gilbert.visible = true
	$BabyGravy.visible = true
	$Jar.visible = false
	$Names.visible = true
	$Names/AnimationPlayer.current_animation = "show_names"
	$Names/AnimationPlayer.play()
	$ShowContinueButtonTimer.start()


func _on_ContinueButton_pressed():
	print("hi")
	MasterScript.after_eggs_to_tadpoles = true
	SceneTransition.change_scene("res://Scenes/Main.tscn")

func _on_ShowContinueButtonTimer_timeout():
	$ContinueButton.visible = true
	
