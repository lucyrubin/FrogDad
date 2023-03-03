extends KinematicBody2D

#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

const ACCELERATION = 460
const MAX_SPEED = 225
var velocity = Vector2.ZERO
const PlayerClass = preload("res://Scripts/FrogDad.gd")
var DoneTalking = false

func _ready():
	pass

func _physics_process(delta):
	
	pass
	
func _input(event):
	if event.is_action_pressed("talk") && $Speech.visible:
		$Speech/Label.text = "Hello"
		$Speech/Timer.start()
		


func _on_Timer_timeout():
	$Speech.visible = false # toggle speech bubble visibility
	DoneTalking = true
	
func _on_Area2D_body_entered(body):
	if body is PlayerClass && !DoneTalking:
		$Speech.visible = true


func _on_Area2D_body_exited(body):
	if $Speech.visible && $Speech/Label.text == "Press A to talk" && !DoneTalking:
		$Speech.visible = false


func _on_Area2D_input_event(viewport, event, shape_idx):
	print(event)
