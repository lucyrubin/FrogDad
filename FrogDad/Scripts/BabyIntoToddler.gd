# music used in this scene:
# A Green Pig by @Pixverses on YouTube
extends Node2D

func _ready():
	BackgroundMusic.stop()
	$CutSceneBackgroundMusic.play()
	yield(get_tree().create_timer(1), "timeout")
	
	# bring gertrude in
	$Gertrude/BabyImage/AnimationPlayer.play("fly_up")
	$SwooshAudio.play()
	yield($Gertrude/BabyImage/AnimationPlayer, "animation_finished")
	
	# wait
	yield(get_tree().create_timer(1), "timeout")
	
	# gertrude grows up
	baby_grow_up($Gertrude)
	yield($Gertrude/ToddlerImage/AnimationPlayer, "animation_finished")
	
	# show gertrude text
	$GertrudeSparkleSound.play()
	yield(show_stats("GERTRUDE","Will probably rule the world one day.",  
		"Likes: \n     - Animals\n     - Fruit salad",  
		"Dislikes: \n     - Cruel injustice"), "completed")
	
	# move gertrude over so that gilbert can come in
	$Gertrude/ToddlerImage/AnimationPlayer.play("move_to_side")
	fade_out_and_reset_stats()
	
	# bring gilbert in
	$Gilbert/BabyImage/AnimationPlayer.play("fly_up")
	yield(get_tree().create_timer(0.5), "timeout")
	$SwooshAudio.play()
	yield($Gilbert/BabyImage/AnimationPlayer, "animation_finished")
	
	# wait
	yield(get_tree().create_timer(1), "timeout")
	
	#gilbert grows up
	baby_grow_up($Gilbert)
	yield($Gilbert/ToddlerImage/AnimationPlayer, "animation_finished")
	
	# show gilbert text
	$GilbertSound.play()
	yield(show_stats("GILBERT", "A little weird but very friendly.",
	"Likes: \n     - Flies\n     -  Throwing pebbles",  
	"Dislikes: \n     - Milk"), "completed")
	
	# move gilbert over so that gravy can come in
	$Gilbert/ToddlerImage/AnimationPlayer.play("move_to_side")
	fade_out_and_reset_stats()
	
	# bring gravy in
	$Gravy/BabyImage/AnimationPlayer.play("fly_up")
	yield(get_tree().create_timer(0.5), "timeout")
	$SwooshAudio.play()
	yield($Gravy/BabyImage/AnimationPlayer, "animation_finished")
	
	# wait
	yield(get_tree().create_timer(1), "timeout")
	
	# gilbert grows up
	baby_grow_up($Gravy)
	yield($Gravy/ToddlerImage/AnimationPlayer, "animation_finished")
	
	# show gravy text
	$GravySound.play()
	yield(show_stats("GRAVY BABY", "Really wants to be a DJ.",
	"Likes: \n     - Being in a groove\n     -  Small bags",  
	"Dislikes: \n     - Being in a funk\n     - Small pockets"), "completed")
	
	# wait
	yield(get_tree().create_timer(1), "timeout")
	
	# move everyone to the middle
	#fade text twice as fast
	$StatsText/AnimationPlayer.playback_speed = 2
	$NameText/AnimationPlayer.playback_speed = 2
	fade_out_and_reset_stats()
	$Gertrude/ToddlerImage/AnimationPlayer.play("move_together")
	$Gilbert/ToddlerImage/AnimationPlayer.play("move_together")
	$Gravy/ToddlerImage/AnimationPlayer.play("move_together")
	
	yield($Gravy/ToddlerImage/AnimationPlayer, "animation_finished")
	
	$ContinueButton.visible = true
	
func fade_out_and_reset_stats():
	$StatsText/AnimationPlayer.play("fade_out")
	$NameText/AnimationPlayer.play("fade_out")
	yield($StatsText/AnimationPlayer, "animation_finished")
	
	$NameText.visible = false
	$StatsText/StatText1.visible = false
	$StatsText/StatText2.visible = false
	$StatsText/StatText3.visible = false
	$StatsText/AnimationPlayer.play("RESET")
	$NameText/AnimationPlayer.play("RESET")
	
func show_stats(baby_name, stat1, stat2, stat3):
	# show name text
	show_text($NameText, baby_name)
	yield($NameText/TextAnimation, "tween_all_completed")
	yield(get_tree().create_timer(1), "timeout")
	
	#stat 1
	show_text($StatsText/StatText1, stat1)
	yield($StatsText/StatText1/TextAnimation, "tween_all_completed")
	yield(get_tree().create_timer(1), "timeout")
	
	#stat 2
	show_text($StatsText/StatText2, stat2 )
	yield($StatsText/StatText2/TextAnimation, "tween_all_completed")
	yield(get_tree().create_timer(1), "timeout")
	
	#stat 3
	show_text($StatsText/StatText3, stat3)
	yield($StatsText/StatText3/TextAnimation, "tween_all_completed")
	yield(get_tree().create_timer(1), "timeout")
	
	

func baby_grow_up(baby_node):
	baby_node.get_node("BabyImage/AnimationPlayer").play("fade")
	baby_node.get_node("ToddlerImage/AnimationPlayer").play("grow")
	

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

func _on_ContinueButton_pressed():
	MasterScript.currentQuestNum = 6
	MasterScript.after_tadpoles_to_babies = true
	SceneTransition.change_scene("res://Scenes/Main.tscn")
	$CutSceneBackgroundMusic.stop()
