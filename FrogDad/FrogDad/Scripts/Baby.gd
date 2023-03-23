extends KinematicBody2D

#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

const ACCELERATION = 460
const MAX_SPEED = 225
var velocity = Vector2.ZERO
const PlayerClass = preload("res://Scripts/FrogDad.gd")
var DoneTalking = false

func _on_Timer_timeout(): # use this for small dialogue bubbles to make them disappear after a while
	pass
#	$Speech.visible = false # toggle speech bubble visibility
#	DoneTalking = true
	
func _on_Area2D_body_entered(body): # if player is nearby, show the action bubble
	if body is PlayerClass && !DoneTalking:
		$Speech.visible = true
	$AnimatedSprite.play("default")


func _on_Area2D_body_exited(body): # if the player has left, hide the action bubble
	if $Speech.visible && $Speech/Label.text == "A" && !DoneTalking:
		$Speech.visible = false


func _on_Area2D_input_event(viewport, event, shape_idx):
	print(event)
