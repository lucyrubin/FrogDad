extends KinematicBody2D
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

const ACCELERATION = 460
const MAX_SPEED = 225
const PlayerClass = preload("res://Scripts/FrogDad.gd")

var velocity = Vector2.ZERO
var done_talking = false
var mouse_in_area = false


	
func _on_Area2D_body_entered(body): # if player is nearby, show the action bubble
	if body is PlayerClass && !done_talking:
		$Speech.visible = true
	$AnimatedSprite.play("default")


func _on_Area2D_body_exited(body): # if the player has left, hide the action bubble
	if $Speech.visible && $Speech/Label.text == "..." && !done_talking:
		$Speech.visible = false

func _input(event):
	# when click on gertrude, open the dialogue box
	if event.is_action_pressed("talk") and mouse_in_area and $Speech.visible:#and !MasterScript.FrogDad.get_node("DialogueBox").visible: 
		MasterScript.FrogDad.toggle_dialogue_box_visibility()
		MasterScript.FrogDad.state = "dialogue"
		MasterScript.FrogDad.get_node("AnimatedSprite").stop()
		$Speech.visible = false
	elif event.is_action_pressed("closeDialogue") and MasterScript.FrogDad.get_node("DialogueBox").visible: # when Enter is pressed, close the dialogue box
		MasterScript.FrogDad.toggle_dialogue_box_visibility()
		MasterScript.FrogDad.state = ""
		MasterScript.FrogDad.get_node("AnimatedSprite").play()
		$Speech.visible = true
		

func _on_ClickArea_mouse_entered():
	mouse_in_area = true


func _on_ClickArea_mouse_exited():
	mouse_in_area = false
