extends Area2D

var TVScene = "res://Scenes/TV.tscn"
var channel = 0
var in_area 

func _on_TV_input_event(_viewport, event, _shape_idx):
	if _left_click_in_area(event):
		channel += 1
		MasterScript.music_position = BackgroundMusic.get_playback_position()
		BackgroundMusic.stop()
		if channel == 1:
			play_NyanCat()
		elif channel == 2:
			stop_NyanCat()
			play_NewJeans()
		elif channel == 3:
			stop_NewJeans()
			play_FrogDad()
		elif channel == 4:
			stop_FrogDad()
			play_SpongeBob()
		else:
			stop_SpongeBob()
			channel = 0
			BackgroundMusic.play(MasterScript.music_position)

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

func _left_click_in_area(event):
	return event is InputEventMouseButton \
	and MasterScript.frog_dad_state == "" \
	and event.button_index == BUTTON_LEFT \
	and event.pressed \
	and in_area

func play_NyanCat():
	$NyanCat.visible = true
	$NyanCat.play()
	$NyanCat/AudioStreamPlayer.play()

func stop_NyanCat():
	$NyanCat.visible = false
	$NyanCat.stop()
	$NyanCat/AudioStreamPlayer.stop()
	
func play_NewJeans():
	$NewJeans.visible = true
	$NewJeans.play()
	$NewJeans/AudioStreamPlayer.play()

func stop_NewJeans():
	$NewJeans.visible = false
	$NewJeans.stop()
	$NewJeans/AudioStreamPlayer.stop()
	
func play_FrogDad():
	$FrogDadDoc.visible = true
	$FrogDadDoc.play()
	$FrogDadDoc/AudioStreamPlayer.play()
	
func stop_FrogDad():
	$FrogDadDoc.visible = false
	$FrogDadDoc.stop()
	$FrogDadDoc/AudioStreamPlayer.stop()
	
func play_SpongeBob():
	$SpongeBob.visible = true
	$SpongeBob.play()
	$SpongeBob/AudioStreamPlayer.play()
	
func stop_SpongeBob():
	$SpongeBob.visible = false
	$SpongeBob.stop()
	$SpongeBob/AudioStreamPlayer.stop()
