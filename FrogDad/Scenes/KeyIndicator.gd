extends Area2D

func _ready():
	$TextureRect/AnimationPlayer.play()

func set_text(text):
	$TextureRect/Label.text = text
