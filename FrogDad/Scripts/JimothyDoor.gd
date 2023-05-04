extends StaticBody2D

export (PackedScene) var target_scene

var door_opened
var current_fram = 0
var num_frames = 2
var mouse_in = false
var close_enough
const PlayerClass = preload("res://Scripts/FrogDad.gd")

func _ready():
	current_fram = 0

func go_inside():
	SceneTransition.change_scene("res://Scenes/JimothyJohns.tscn")

func _on_Area2D_body_entered(body):
	if body is PlayerClass:
		door_opened = true
		$Sprite.texture = load("res://JJ\'s Art/jimothydooropennew.png")
		close_enough = true

func _on_Area2D_body_exited(body):
	if body is PlayerClass: 
		door_opened = false
		$Sprite.texture = load("res://JJ\'s Art/jimothynew.png")
		close_enough = false

func _on_JimothyDoor_body_entered(body):

	if body is PlayerClass:
		go_inside()
