extends Area2D

onready var frogdad_node = get_tree().get_root().find_node("FrogDad",true, false)

var TVScene = "res://Scenes/TV.tscn"
var channel = 0
var mouse_in
var in_area
var TV_on

func _ready():
	in_area = false
	mouse_in = false

func _on_TV_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and frogdad_node.state == "":
		if in_area and mouse_in:
			turn_TV_on()

func turn_TV_on():
	TV_on = true
	BackgroundMusic.stop()
	$NyanCat.visible = true
	$NyanCat.play()
	$NyanCat/AudioStreamPlayer.play()

func _on_TV_area_entered(area):
	if frogdad_node.state == "":
		in_area = true
		$AnimatedSprite.animation = "hover"

func _on_TV_area_exited(area):
	if frogdad_node.state == "":
		in_area = false
		$AnimatedSprite.animation = "default"

func _on_TV_mouse_entered():
	if frogdad_node.state == "":
		mouse_in = true
		$AnimatedSprite.animation = "hover"

func _on_TV_mouse_exited():
	if frogdad_node.state == "":
		mouse_in = false
		$AnimatedSprite.animation = "default"

func _on_NextButton_pressed():
	if TV_on == true:
		if channel == 0:
			stop_NyanCat()
			play_NewJeans()
			channel += 1
		else:
			stop_NewJeans()
			play_NyanCat()
			channel -= 1

func _on_PauseButton_pressed():
	if TV_on == true:
		stop_NewJeans()
		stop_NyanCat()
		BackgroundMusic.play()

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
