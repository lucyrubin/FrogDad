extends KinematicBody2D
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

const PlayerClass = preload("res://Scripts/FrogDad.gd")


var done_talking = false
var mouse_in_area = false
onready var FrogDad = get_tree().get_root().find_node("FrogDad", true, false)

# if player is nearby, show the action bubble
func _on_Area2D_body_entered(body): 

	if body is PlayerClass && !done_talking:
		$Speech.visible = true
	$AnimatedSprite.play("default")


# if the player has left, hide the action bubble
func _on_Area2D_body_exited(_body): 
	if $Speech.visible && !done_talking:
		$Speech.visible = false

# when click on gertrude, open the dialogue box
func _input(event):
	if event.is_action_pressed("talk") and mouse_in_area and $Speech.visible:
		FrogDad.toggle_dialogue_box_visibility([{avatar = "gertrude", text = "Hi Frog Dad!"},
			{avatar = "frogDad", text = "Hi Gertrude!"},
			{avatar = "gertrude", text = "What are we doing today?"},
			{avatar = "frogDad", text = "Whatever you want."}
		], "Gertrude talk")
		FrogDad.state = "dialogue"
		FrogDad.get_node("AnimatedSprite").stop()
		$Speech.visible = false
	
# Handles whether the mouse is on Gertrude or not
func _on_ClickArea_mouse_entered():
	mouse_in_area = true 

# Handles whether the mouse is on Gertrude or not
func _on_ClickArea_mouse_exited():
	mouse_in_area = false
