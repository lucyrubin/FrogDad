extends Area2D

onready var frogdad_node = get_tree().get_root().find_node("FrogDad",true, false)

var TVScene = "res://Scenes/TV.tscn"
var channel = 0
var in_area 

func _on_TV_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed \
	and MasterScript.frog_dad_state == "" \
	and in_area == true:
		channel += 1
		BackgroundMusic.stop()
		if channel == 1:
			play_NyanCat()
		elif channel == 2:
			stop_NyanCat()
			play_NewJeans()
		elif channel == 3:
			stop_NewJeans()
			play_FrogDad()
		else:
			stop_FrogDad()
			channel = 0
			BackgroundMusic.play()

func _on_TV_mouse_entered():
	if MasterScript.frog_dad_state == "" and in_area == true:
		$AnimatedSprite.animation = "hover"
		Input.set_custom_mouse_cursor(MasterScript.pointer)

func _on_TV_mouse_exited():
	if MasterScript.frog_dad_state == "":
		$AnimatedSprite.animation = "default"
		Input.set_custom_mouse_cursor(MasterScript.hand)
		
func _on_TV_Area_entered(area):
	if MasterScript.frog_dad_state == "":
		in_area = true

func _on_TV_Area_exited(area):
	if MasterScript.frog_dad_state == "":
		in_area = false

func play_NyanCat():
	$AnimatedSprite/NyanCat.visible = true
	$AnimatedSprite/NyanCat.play()
	$AnimatedSprite/NyanCat/AudioStreamPlayer.play()

func stop_NyanCat():
	$AnimatedSprite/NyanCat.visible = false
	$AnimatedSprite/NyanCat.stop()
	$AnimatedSprite/NyanCat/AudioStreamPlayer.stop()
	
func play_NewJeans():
	$AnimatedSprite/NewJeans.visible = true
	$AnimatedSprite/NewJeans.play()
	$AnimatedSprite/NewJeans/AudioStreamPlayer.play()

func stop_NewJeans():
	$AnimatedSprite/NewJeans.visible = false
	$AnimatedSprite/NewJeans.stop()
	$AnimatedSprite/NewJeans/AudioStreamPlayer.stop()
	
func play_FrogDad():
	$AnimatedSprite/FrogDadDoc.visible = true
	$AnimatedSprite/FrogDadDoc.play()
	$AnimatedSprite/FrogDadDoc/AudioStreamPlayer.play()
	
func stop_FrogDad():
	$AnimatedSprite/FrogDadDoc.visible = false
	$AnimatedSprite/FrogDadDoc.stop()
	$AnimatedSprite/FrogDadDoc/AudioStreamPlayer.stop()
