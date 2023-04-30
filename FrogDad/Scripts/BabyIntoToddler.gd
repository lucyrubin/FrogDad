extends Node2D

func _ready():
	# wait
	yield(get_tree().create_timer(1), "timeout")
	
	baby_grow_up($Gertrude)
	
	yield($Gertrude/ToddlerImage/AnimationPlayer, "animation_finished")
	
	yield(show_stats("GERTRUDE:","will probably rule the world one day",  
		"likes: \n     - animals\n     - fruit salad",  
		"dislikes: \n     - cruel injustice"), "completed")
	# move gertrude over so that gilbert can come in
	$Gertrude/ToddlerImage/AnimationPlayer.play("move_to_side")
	fade_out_and_reset_stats()
	
	# bring gilbert in
	$Gilbert/BabyImage/AnimationPlayer.play("fly_up")
	
	yield($Gilbert/BabyImage/AnimationPlayer, "animation_finished")
	
	# wait
	yield(get_tree().create_timer(1), "timeout")
	
	baby_grow_up($Gilbert)
	
	yield($Gilbert/ToddlerImage/AnimationPlayer, "animation_finished")
	
	
	yield(show_stats("GILBERT:", "a little weird but very friendly",
	"likes: \n     - flies\n     -  throwing pebbles",  
	"dislikes: \n     - milk"), "completed")
	
	# move gilbert over so that gravy can come in
	$Gilbert/ToddlerImage/AnimationPlayer.play("move_to_side")
	fade_out_and_reset_stats()
	
	# bring gravy in
	$Gravy/BabyImage/AnimationPlayer.play("fly_up")
	
	yield($Gravy/BabyImage/AnimationPlayer, "animation_finished")
	
	# wait
	yield(get_tree().create_timer(1), "timeout")
	
	baby_grow_up($Gravy)
	
	yield($Gravy/ToddlerImage/AnimationPlayer, "animation_finished")
	
	yield(show_stats("GRAVY BABY:", "really wants to be a DJ",
	"likes: \n     - being in the grove\n     -  small bags",  
	"dislikes: \n     - being in a funk\n     - small pockets"), "completed")
	
	yield(get_tree().create_timer(1), "timeout")
	$ContinueButton.visible = true
	
func fade_out_and_reset_stats():
	$StatsText/AnimationPlayer.play("fade_out")
	yield($StatsText/AnimationPlayer, "animation_finished")
	
	$StatsText/NameText.visible = false
	$StatsText/StatText1.visible = false
	$StatsText/StatText2.visible = false
	$StatsText/StatText3.visible = false
	$StatsText/AnimationPlayer.play("RESET")
	
func show_stats(baby_name, stat1, stat2, stat3):
	# show name text
	show_text($StatsText/NameText, baby_name)
	yield($StatsText/NameText/TextAnimation, "tween_all_completed")
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
	MasterScript.after_tadpoles_to_babies = true
	SceneTransition.change_scene("res://Scenes/Main.tscn")
