extends Node2D

var VELOCITY = 4.5
var ACCELERATION = 0.04
var start = false

func _ready():
	$WaitToStartAnimationTimer.start()

func _process(delta):
	if VELOCITY > 0 and start:
		$Note.position.y += VELOCITY
		VELOCITY -= ACCELERATION





func _on_WaitToStartAnimationTimer_timeout():
	start = true
	$WaitToStartAnimationTimer.queue_free()


func _on_Button_pressed():

	
	# when the note is picked up, show the close up note and delete the small one
	#$Label.add_color_override("font_color", Color(0,0,0,1))
	$CloseUpNote.visible = true
	$DarkBackground.visible = true
	#FrogDad.state = "reading note"
	
	#queue_free()


func _on_Button_mouse_entered():
	print("hi")
	$Note/Label.add_color_override("font_color", Color(50,0,100,1))


func _on_Button_mouse_exited():
	$Note/Label.add_color_override("font_color", Color(0,0,0,1))


func _input(event):
	if event is InputEventMouseButton: 
		if event.button_index == BUTTON_LEFT && event.pressed: 
			if $CloseUpNote.visible:
			
				## change scene to the cut scene of the eggs
				MasterScript.currentQuestNum +=1
				SceneTransition.change_scene("res://Scenes/FindBabiesCutScene.tscn")
