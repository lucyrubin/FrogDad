extends Node2D


func _ready():
	BackgroundMusic.stop()
	$CreditMusic.play()
	# end credit music by @HeatleyBros on YoutTube
	yield(run_intro(), "completed")
	
	


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
	label.visible = false
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
	$FirstPart/BouncingArrow.hide()
	$FirstPart/Button.hide()
	$FirstPart/Button.disabled = true
	Input.set_custom_mouse_cursor(MasterScript.hand)
	yield(run_baby($SecondPart/BabyGertrude/AnimationPlayer,
	 $SecondPart/OlderGertrude/AnimationPlayer, 
	"Gertrude became the youngest and first ever frog president of the United States. ", 
	"She's also the only president in history with a 100% approval rate.", 
	"Her first actions as president were abolishing the electoral college and banning cruel injustice."), 
	"completed")

	# can get rid of the title screen stuff after the first character has gone
	$FirstPart.hide()
	$SecondPart/PermanentBackground.show()

	yield(run_baby($SecondPart/BabyGilbert/AnimationPlayer, 
	$SecondPart/OlderGilbert/AnimationPlayer,
	"Gilbert went on to major in Computer Science at a small liberal arts college where he made a groundbreaking, award-winning video game about his childhood.",
	"", 
	"He sends money home to his dad every week."), 
	"completed")

	yield(run_baby($SecondPart/BabyGravy/AnimationPlayer,
	$SecondPart/OlderGravy/AnimationPlayer,
	"Gravy Baby became a 20-time Grammy-winning producer and DJ, making the sickest beats known to man.",
	"",
	"He still can't stand small pockets."),
	 "completed")

	yield(run_side_character($SecondPart/Odie/AnimationPlayer,
	"RIP 1871-2023",
	"Odie finally reunited with his beloved, Darla.",
	"He left everything behind to Mary-Beth."),
	"completed")

	yield(run_side_character($SecondPart/Snail/AnimationPlayer,
	"Legend has it he's still in front of the Jimothy John's, jamming out to his pink radio.",
	"",
	""),
	"completed")
	
	yield(run_side_character($SecondPart/Jimothy/AnimationPlayer, 
	"Business is booming at Jimothy John's.",
	"Jimothy got closer to an old friend and a romance has begun.",
	"But that's a story for another time..."), 
	"completed")
	
	yield(run_frog_dad(), "completed")
	
	yield(get_tree().create_timer(2), "timeout")
	
	$QuitButton.disabled = false
	$QuitButton.show()



func _on_Button_mouse_entered():
	Input.set_custom_mouse_cursor(MasterScript.pointer)


func _on_Button_mouse_exited():
	Input.set_custom_mouse_cursor(MasterScript.hand)

func run_frog_dad():
	
	$SecondPart.show()
	$SecondPart/Background2/AnimationPlayer.play("RESET")
	$SecondPart/Label1.text = ""
	$SecondPart/Label2.text = ""
	$SecondPart/Label3.text = ""
	
	$FirstPart/DarkOverlay.hide()
	$SecondPart/Background/AnimationPlayer.play("walk_in")
	yield(get_tree().create_timer(1.5), "timeout")
	
	var frog_dad = $SecondPart/FrogDad
	var frog_dad_animation_player = $SecondPart/FrogDad/AnimationPlayer
	frog_dad_animation_player.play("walk_in_from_side")
	yield(frog_dad_animation_player, "animation_finished")
	frog_dad.animation = "down"
	frog_dad.frame = 0
	
	yield(get_tree().create_timer(1.5), "timeout")
	show_text($SecondPart/Label1, "After becoming an empty nester, Frog Dad discovered his love for cooking, which brought him closer to Jimothy.")
	yield($SecondPart/Label1/TextAnimation, "tween_all_completed")
	yield(get_tree().create_timer(1), "timeout")
	show_text($SecondPart/Label2, "")
	yield($SecondPart/Label2/TextAnimation, "tween_all_completed")
	yield(get_tree().create_timer(1), "timeout")
	show_text($SecondPart/Label3, "His kids come over for flylafel dinner every Saturday night.")
	yield($SecondPart/Label3/TextAnimation, "tween_all_completed")
	
	yield(get_tree().create_timer(3), "timeout")
	frog_dad.animation = "right"
	frog_dad.frame = 0
	frog_dad_animation_player.play("walk_away")
	$SecondPart/Background2.show()
	$SecondPart/Background2/AnimationPlayer.play("walk_away")
	
	
	
func run_baby(baby_animation_player, older_animation_player, text1, text2, text3):
	# reset stuff
	$SecondPart.show()
	$SecondPart/Background2/AnimationPlayer.play("RESET")
	$SecondPart/Label1.text = ""
	$SecondPart/Label2.text = ""
	$SecondPart/Label3.text = ""
	
	# bring baby in
	$SecondPart/Background/AnimationPlayer.play("walk_in")
	yield(get_tree().create_timer(1.5), "timeout")
	
	baby_animation_player.play("walk_in_from_side")
	yield(baby_animation_player, "animation_finished")
	
	yield(get_tree().create_timer(1), "timeout")
	
	# gertrude grow up
	baby_animation_player.play("fade_out")
	older_animation_player.play("fly_up")
	if baby_animation_player == $SecondPart/BabyGertrude/AnimationPlayer:
		$GertrudeSparkleSound.play()
	elif baby_animation_player == $SecondPart/BabyGilbert/AnimationPlayer:
		$GilbertSound.play()
	elif baby_animation_player == $SecondPart/BabyGravy/AnimationPlayer:
		$GravySound.play()
	yield(older_animation_player, "animation_finished")
	
	baby_animation_player.play("RESET")
	
	# play gertrude text
	yield(get_tree().create_timer(1.5), "timeout")
	show_text($SecondPart/Label1, text1)
	yield($SecondPart/Label1/TextAnimation, "tween_all_completed")
	yield(get_tree().create_timer(1), "timeout")
	show_text($SecondPart/Label2, text2)
	yield($SecondPart/Label2/TextAnimation, "tween_all_completed")
	yield(get_tree().create_timer(1), "timeout")
	show_text($SecondPart/Label3, text3)
	yield($SecondPart/Label3/TextAnimation, "tween_all_completed")
	
	yield(get_tree().create_timer(3), "timeout")
	
	older_animation_player.play("walk_away")
	$SecondPart/Background2.show()
	$SecondPart/Background2/AnimationPlayer.play("walk_away")
	
	yield($SecondPart/Background2/AnimationPlayer, "animation_finished")
	
	
	
		
func run_side_character(animation_player, text1, text2, text3):
	# reset stuff
	$SecondPart.show()
	$SecondPart/Background2/AnimationPlayer.play("RESET")
	$SecondPart/Label1.text = ""
	$SecondPart/Label2.text = ""
	$SecondPart/Label3.text = ""
	
	# bring character in
	$SecondPart/Background/AnimationPlayer.play("walk_in")
	yield(get_tree().create_timer(1.5), "timeout")
	
	animation_player.play("walk_in_from_side")
	yield(animation_player, "animation_finished")
	
	if animation_player == $SecondPart/Snail/AnimationPlayer:
		$SecondPart/Snail.animation = "back_and_forth"
		$SecondPart/Snail.frame = 9
	
	yield(get_tree().create_timer(1), "timeout")
	
	# play character text
	yield(get_tree().create_timer(1.5), "timeout")
	show_text($SecondPart/Label1, text1)
	yield($SecondPart/Label1/TextAnimation, "tween_all_completed")
	yield(get_tree().create_timer(1), "timeout")
	show_text($SecondPart/Label2, text2)
	yield($SecondPart/Label2/TextAnimation, "tween_all_completed")
	yield(get_tree().create_timer(1), "timeout")
	show_text($SecondPart/Label3, text3)
	yield($SecondPart/Label3/TextAnimation, "tween_all_completed")
	
	yield(get_tree().create_timer(3), "timeout")
	
	if animation_player == $SecondPart/Snail/AnimationPlayer:
		$SecondPart/Snail.animation = "right"
		$SecondPart/Snail.frame = 0
	animation_player.play("walk_away")
	$SecondPart/Background2.show()
	$SecondPart/Background2/AnimationPlayer.play("walk_away")
	
	yield($SecondPart/Background2/AnimationPlayer, "animation_finished")


func _on_QuitButton_pressed():
	get_tree().quit()
