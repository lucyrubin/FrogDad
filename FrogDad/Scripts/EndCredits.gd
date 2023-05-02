extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	run_intro()


func run_intro():
	yield(get_tree().create_timer(1), "timeout")
	show_text($FirstPart/ThanksForPlaying, "Thank you for playing")
	yield($FirstPart/ThanksForPlaying/TextAnimation, "tween_all_completed")
	yield(get_tree().create_timer(1), "timeout")
	$FirstPart/TextureRect/AnimationPlayer.play("fade_in")
	$FirstPart/DarkOverlay/AnimationPlayer.play("fade_out")
	$FirstPart/ThanksForPlaying/AnimationPlayer.play("fade_out")
	
	yield($FirstPart/DarkOverlay/AnimationPlayer,"animation_finished")
	$FirstPart/DarkOverlay.hide()
	$FirstPart/Button.show()
	$FirstPart/BouncingArrow.show()

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
	


func _on_FrogDad_Button_pressed():
	$FirstPart.hide()
		
	run_frog_dad()



func _on_Button_mouse_entered():
	Input.set_custom_mouse_cursor(MasterScript.pointer)


func _on_Button_mouse_exited():
	Input.set_custom_mouse_cursor(MasterScript.hand)

func run_frog_dad():
	$SecondPart.show()
	var frog_dad = $SecondPart/Background/FrogDad
	var frog_dad_animation_player = $SecondPart/Background/FrogDad/AnimationPlayer
	frog_dad_animation_player.play("walk_in_from_side")
	yield(frog_dad_animation_player, "animation_finished")
	frog_dad.playing = false
	frog_dad.animation = "down"
	frog_dad.frame = 0
	
	yield(get_tree().create_timer(1.5), "timeout")
	show_text($SecondPart/VBoxContainer/Label1, "Frog Dad is doing this now")
	yield($SecondPart/VBoxContainer/Label1/TextAnimation, "tween_all_completed")
	yield(get_tree().create_timer(1), "timeout")
	show_text($SecondPart/VBoxContainer/Label2, "Wow he is also doing this")
	yield($SecondPart/VBoxContainer/Label2/TextAnimation, "tween_all_completed")
	yield(get_tree().create_timer(1), "timeout")
	show_text($SecondPart/VBoxContainer/Label3, "He is so cool")
	yield($SecondPart/VBoxContainer/Label3/TextAnimation, "tween_all_completed")
	
	
