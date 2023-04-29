extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	BackgroundMusic.stop()
	$Cradle/Sprite.visible = false
	$Jar.visible = false
	$Sparkles.visible = false
	$Smoke.play()
	$Cradle/Sprite.visible = true
	$Jar.visible = true
	$Sparkles.visible = true
	$Sparkles.play()
	$AudioStreamPlayer.play()

func _on_Timer_timeout():
	# change this to next to the cradle
	BackgroundMusic.play()
	MasterScript.enter_cradle_area = true
	SceneTransition.change_scene("res://Scenes/Main.tscn")
