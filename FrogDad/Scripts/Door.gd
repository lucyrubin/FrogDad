extends Area2D

export (PackedScene) var target_scene = load("res://Scenes/Outdoors.tscn")

var door_opened = false
var current_fram = 0
var num_frames = 2
var locked = false
var mouse_in = false

func _ready():
	$AnimatedSprite.animation = "default"
	current_fram = 0

func _input(event):
	if event.is_action_pressed("open"):
		if !target_scene:
			print("no scene in this door")
		if door_opened and mouse_in:
			go_outside()
	
func set_locked(boolean):
	locked = boolean

func go_outside():
	if !locked:
		MasterScript.exit_home = true
		var ERR = get_tree().change_scene_to(target_scene)
		if ERR != OK:
			print("something failed in the door scene")

func _on_Door_area_entered(area):
	if !locked:
		$AnimatedSprite.animation = "default"
		door_opened = true
		current_fram = 1
		$AnimatedSprite.set_frame(current_fram)

func _on_Door_area_exited(area):
	if !locked:
		$AnimatedSprite.animation = "default"
		door_opened = false
		current_fram = 0
		$AnimatedSprite.set_frame(current_fram)

func _on_DoorMouseArea_mouse_entered():
	if !locked && door_opened:
		$AnimatedSprite.animation = "hover"
		$AnimatedSprite.set_frame(current_fram)
		mouse_in = true

func _on_DoorMouseArea_mouse_exited():
	if !locked && door_opened:
		$AnimatedSprite.animation = "default"
		$AnimatedSprite.set_frame(current_fram)
		mouse_in = false
