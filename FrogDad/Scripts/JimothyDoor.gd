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

func _input(event):
	if event.is_action_pressed("open"):
		if !target_scene:
			print("no scene in this door")
		if door_opened && mouse_in:
			go_inside()
			

func go_inside():
	MasterScript.enter_home = true
	var ERR = get_tree().change_scene_to(target_scene)
	if ERR != OK:
		print("something failed in the door scene")
	

func _on_Area2D_body_entered(body):
	if body is PlayerClass:
		door_opened = true
		$Sprite.texture = load("res://JJ\'s Art/JimothyJohnsDoorOpen.png")
		close_enough = true


func _on_Area2D_body_exited(body):
	if body is PlayerClass: 
		door_opened = false
		$Sprite.texture = load("res://JJ\'s Art/JimothyJohns.png")
		close_enough = false



func _on_JimothyDoor_mouse_entered():
	if close_enough:
		mouse_in = true
		$Sprite.texture = load("res://JJ\'s Art/JiimothyJohnsDoorHover.png")
		Input.set_custom_mouse_cursor(MasterScript.pointer)



func _on_JimothyDoor_mouse_exited():
	mouse_in = false
	Input.set_custom_mouse_cursor(MasterScript.hand)
	if door_opened:
		$Sprite.texture = load("res://JJ\'s Art/JimothyJohnsDoorOpen.png")
	else:
		$Sprite.texture =load("res://JJ\'s Art/JimothyJohns.png")

