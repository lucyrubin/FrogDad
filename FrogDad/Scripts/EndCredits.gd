extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(1), "timeout")
	show_text($ThanksForPlaying, "Thank you for playing")
	yield($ThanksForPlaying/TextAnimation, "tween_all_completed")
	yield(get_tree().create_timer(1), "timeout")
	$TextureRect/AnimationPlayer.play("fade_in")
	$DarkOverlay/AnimationPlayer.play("fade_out")
	$ThanksForPlaying/AnimationPlayer.play("fade_out")

func show_text(label, text_to_show):
	var text_animation = label.get_node("TextAnimation")
	var interval = 0.05
	label.text = text_to_show
	text_animation.interpolate_property(
			label, "percent_visible", 0, 1, 
			interval * label.text.length(),
			text_animation.TRANS_LINEAR
		)
	text_animation.start()
	yield(get_tree().create_timer(0.1), "timeout")
	label.visible = true
	
