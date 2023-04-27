extends KinematicBody2D

# script that all babies use
export (String) var baby_name
const PlayerClass = preload("res://Scripts/FrogDad.gd")
onready var FrogDad = get_tree().get_root().find_node("FrogDad", true, false)
var dialogue_finished = false
var mouse_in_area = false
var player_close_to_baby = false

# when gertude is clicked, open the dialogue box
func _input(event):
	if event.is_action_pressed("talk") and mouse_in_area and player_close_to_baby:
		if baby_name == "Gertrude":
			 #{question, correct_answer : , wrong_answer1: , wrong_answer2: , question_name : }
			MasterScript.odie_quest_active = true # get rid of this once testing is done and give it to odie
			FrogDad.toggle_riddle_visibility([[{avatar = "gertrude", text = "I can be broken without being touched or seen. What am I?" }], {correct_answer = "Promise", wrong_answer1 = "Heart", wrong_answer2 = "My Legs )-:", question_name = "keyword"}])
#			FrogDad.toggle_dialogue_box_visibility([{avatar = "gertrude", text = "Hi Frog Dad!"},
#				{avatar = "frogDad", text = "Hi Gertrude!"},
#				{avatar = "gertrude", text = "What are we doing today?"},
#				{avatar = "frogDad", text = "Whatever you want."}
#			], "Gertrude talk")

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
	if body is PlayerClass && !dialogue_finished:
		$Speech.visible = true
		player_close_to_baby = true
	$AnimatedSprite.play("default")

# if the player has left, hide the action bubble
func _on_Interactable_body_exited(_body):
	if $Speech.visible && !dialogue_finished:
		$Speech.visible = false
		player_close_to_baby = false



