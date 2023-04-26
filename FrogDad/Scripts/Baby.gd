extends KinematicBody2D
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

const PlayerClass = preload("res://Scripts/FrogDad.gd")

export (String) var baby_name
var done_talking = false
var mouse_in_area = false
onready var FrogDad = get_tree().get_root().find_node("FrogDad", true, false)


	
# when click on gertrude, open the dialogue box
func _input(event):
	if event.is_action_pressed("talk") and mouse_in_area and $Speech.visible:
		if baby_name == "Gertrude":
			FrogDad.toggle_dialogue_box_visibility([{avatar = "gertrude", text = "Hi Frog Dad!"},
				{avatar = "frogDad", text = "Hi Gertrude!"},
				{avatar = "gertrude", text = "What are we doing today?"},
				{avatar = "frogDad", text = "Whatever you want."}
			], "Gertrude talk")
			
		if baby_name == "Gilbert":
			FrogDad.toggle_dialogue_box_visibility([{avatar = "gilbert", text = "hi"},
					{avatar = "frogDad", text = "Hi gilbert!"},
					{avatar = "gilbert", text = "hiiiiii"},
					{avatar = "frogDad", text = "hi :)"}
				], "Gilbert talk")
		
		if baby_name == "Gravy Baby":
			FrogDad.toggle_dialogue_box_visibility([{avatar = "gravy", text = "gravy"},
					{avatar = "frogDad", text = "yes"},
					{avatar = "gravy", text = "im gravy baby"},
					{avatar = "frogDad", text = "yes"}
				], "Gravy talk")
		
		
			
		MasterScript.frog_dad_state = "dialogue"
		FrogDad.get_node("AnimatedSprite").stop()
		$Speech.visible = false
	
# Handles whether the mouse is on Gertrude or not
func _on_ClickArea_mouse_entered():
	mouse_in_area = true 

# Handles whether the mouse is on Gertrude or not
func _on_ClickArea_mouse_exited():
	mouse_in_area = false

# if player is nearby, show the action bubble
func _on_Interactable_body_entered(body):
	if body is PlayerClass && !done_talking:
		$Speech.visible = true
	$AnimatedSprite.play("default")

# if the player has left, hide the action bubble
func _on_Interactable_body_exited(body):
	if $Speech.visible && !done_talking:
		$Speech.visible = false



