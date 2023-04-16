extends Area2D

onready var frogdad_node = get_tree().get_root().find_node("FrogDad",true, false)

var TVScene = "res://Scenes/TV.tscn"
var channel = 0
var mouse_in
var area_entered

func _ready():
	mouse_in = false
	area_entered = false

func _on_TV_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed \
	and frogdad_node.state == "":
		if mouse_in:
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
	if frogdad_node.state == "" and area_entered:
		mouse_in = true
		$AnimatedSprite.animation = "hover"

func _on_TV_mouse_exited():
	if frogdad_node.state == "" and area_entered:
		mouse_in = false
		$AnimatedSprite.animation = "default"
		
func _on_TV_area_entered(area):
	if frogdad_node.state == "":
		area_entered = true

func _on_TV_area_exited(area):
	if frogdad_node.state == "":
		area_entered = false

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
