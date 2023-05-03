extends Node2D

func _on_Timer_timeout():
	$Gertrude.visible = true
	$Gilbert.visible = true
	$BabyGravy.visible = true
	$Jar.visible = false
	
	yield($Fade/AnimationPlayer, "animation_finished")

	$Names/AnimationPlayer.current_animation = "show_names"
	$Names/AnimationPlayer.play()
	$Names.visible = true
	$ShowContinueButtonTimer.start()
	
	yield(get_tree().create_timer(1), "timeout")
	$GertrudeSparkleSound.play()
	
	yield(get_tree().create_timer(1), "timeout")
	$GilbertSound.play()
	
	yield(get_tree().create_timer(1), "timeout")
	$GravySound.play()

func _on_ContinueButton_pressed():
	MasterScript.after_eggs_to_tadpoles = true
	SceneTransition.change_scene("res://Scenes/Main.tscn")

func _on_ShowContinueButtonTimer_timeout():
	$ContinueButton.visible = true
