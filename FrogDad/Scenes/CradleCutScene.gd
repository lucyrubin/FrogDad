extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
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
	# change this to next to the cradle
	MasterScript.enter_cradle_area = true
	SceneTransition.change_scene("res://Scenes/Main.tscn")
