extends Area2D

export (PackedScene) var target_scene 

var door_opened = false
var current_fram = 0
var num_frames = 2
var locked = false
var mouse_in = false
const FrogDadClass = preload("res://Scripts/FrogDad.gd")

onready var FrogDad = get_tree().get_root().find_node("FrogDad", true, false)

func _ready():
	$AnimatedSprite.animation = "default"
	current_fram = 0
	$AnimatedSprite.set_frame(current_fram)
	
func set_locked(boolean):
	current_fram = 0
	$AnimatedSprite.set_frame(current_fram)
	locked = boolean

func go_outside():
	if !locked:
		MasterScript.exit_home = true
		SceneTransition.change_scene("res://Scenes/Outdoors.tscn")
		
func _on_Door_area_entered(_area):
	if MasterScript.currentQuestNum == -1:
		current_fram = 0
		$AnimatedSprite.set_frame(current_fram)
	else:
		$AnimatedSprite.animation = "hover"
		door_opened = true
		current_fram = 1
		$AnimatedSprite.set_frame(current_fram)

func _on_Door_area_exited(_area):
	if !locked:
		$AnimatedSprite.animation = "default"
		door_opened = false
		current_fram = 0
		$AnimatedSprite.set_frame(current_fram)

func _on_EnteranceArea_body_entered(body):
	if body is FrogDadClass and !locked:
		go_outside()
