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
		
	run_frog_dad()



func _on_Button_mouse_entered():
	Input.set_custom_mouse_cursor(MasterScript.pointer)


func _on_Button_mouse_exited():
	Input.set_custom_mouse_cursor(MasterScript.hand)

func run_frog_dad():
	$SecondPart.show()
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
	
	run_gertrude()
	
	
func run_gertrude():
	$SecondPart.show()
	$SecondPart/Background/AnimationPlayer.play("walk_in")
	yield(get_tree().create_timer(1.5), "timeout")
	
	var gertrude = $SecondPart/BabyGertrude
	var gertrude_animation_player = $SecondPart/BabyGertrude/AnimationPlayer
	gertrude_animation_player.play("walk_in_from_side")
	yield(gertrude_animation_player, "animation_finished")
	
	yield(get_tree().create_timer(1.5), "timeout")
	show_text($SecondPart/Label1, "Gertrude became the youngest and first ever frog president of the united states. ")
	yield($SecondPart/Label1/TextAnimation, "tween_all_completed")
	yield(get_tree().create_timer(1), "timeout")
	show_text($SecondPart/Label2, "She's also the only president in history with a 100% approval rate")
	yield($SecondPart/Label2/TextAnimation, "tween_all_completed")
	yield(get_tree().create_timer(1), "timeout")
	show_text($SecondPart/Label3, "Her first actions as president were abolishing the electoral college and banning cruel injustice.")
	yield($SecondPart/Label3/TextAnimation, "tween_all_completed")
	
	yield(get_tree().create_timer(3), "timeout")
	
	gertrude_animation_player.play("walk_away")
	$SecondPart/Background2.show()
	$SecondPart/Background2/AnimationPlayer.play("walk_away")
	
	
	
	
	
#	gertrude became the youngest and first ever frog president of the united states. 
#	she's also the only president in history with a 100% approval rate
#	her first actions as president were abolishing the electoral college and banningcruel injustice


# Gilbert went on to a small liberal arts college where he made a groundbreaking, award-winning 
# video game about his childhood 
# he sends home money to his dad every week

# Gravy baby became a 20-time grammy winning producer and DJ,
# making the sickest beats known to man


# Odie
# RIP 1871-2023
# Odie finally reunited with his beloved, Darla. He left everything behind to Mary-Beth

# Snail
# legend says he's still in front of the Jimothy John's, jamming out to his pink radio


# jimothy
# got closer to an old friend, and a budding romance has begun
# but that's a story for another time...

#Frog Dad 

