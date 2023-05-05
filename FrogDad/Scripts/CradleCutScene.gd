extends Node2D

func _ready():
	# play animation
	BackgroundMusic.play(MasterScript.music_position)
	Input.set_custom_mouse_cursor(MasterScript.hand)
	$Cradle.visible = false
	$Jar.visible = false
	$Sparkles.visible = false
	$Smoke.play()
	$AudioStreamPlayer.play()
	yield($Smoke,"animation_finished")
	$Smoke.visible = false
	$Cradle.visible = true
	$Jar.visible = true
	$Sparkles.visible = true
	$Sparkles.play()
	

func _on_Timer_timeout():
	# end animation
	MasterScript.enter_cradle_area = true
	SceneTransition.change_scene("res://Scenes/Main.tscn")
