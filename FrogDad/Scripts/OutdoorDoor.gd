extends Area2D

export (PackedScene) var target_scene = load("res://Scenes/Main.tscn")

var door_opened
var current_fram = 0
var num_frames = 2
var mouse_in = false
const FrogDadClass = preload("res://Scripts/FrogDad.gd")

func _ready():
	current_fram = 0

func _input(event):
	if event.is_action_pressed("open"):
		if !target_scene:
			print("no scene in this door")
		if door_opened && mouse_in:
			go_inside()

func go_inside():
	MasterScript.enter_home = true
	SceneTransition.change_scene("res://Scenes/Main.tscn")

func _on_OutdoorDoor_area_entered(_area):
	door_opened = true
	current_fram = 1
	$AnimatedSprite.animation = "hover"
	$AnimatedSprite.set_frame(current_fram)

func _on_OutdoorDoor_area_exited(_area):
	door_opened = false
	current_fram = 0
	$AnimatedSprite.animation = "default"
	$AnimatedSprite.set_frame(current_fram)
	Input.set_custom_mouse_cursor(MasterScript.hand)

func _on_EnteranceArea_body_entered(body):
	if body is FrogDadClass:
		go_inside()
