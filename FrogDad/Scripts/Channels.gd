extends Node2D

var MainScene = "res://Scenes/Main.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	$NyanCat/AudioStreamPlayer.play()

func _on_Button_pressed():
	SceneTransition.change_scene(MainScene)
