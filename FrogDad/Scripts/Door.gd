extends Area2D

export (PackedScene) var target_scene = load("res://Scenes/Outdoors.tscn")

var door_opened = false
var current_fram = 0
var num_frames = 2
var locked = false

func _ready():
	$AnimatedSprite.animation = "default"

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if !target_scene:
			print("no scene in this door")
		if door_opened:
			go_outside()
func set_locked(boolean):
	locked = boolean

func go_outside():
	if !locked:
		var ERR = get_tree().change_scene_to(target_scene)
		if ERR != OK:
			print("something failed in the door scene")

func _on_Door_area_entered(area):
	print(locked)
	if locked == false:
		$AnimatedSprite.animation = "hover"
		door_opened = true
		current_fram = 1#(current_fram+1) % num_frames
		$AnimatedSprite.set_frame(current_fram)
		

func _on_Door_area_exited(area):
	if locked == false:
		$AnimatedSprite.animation = "default"
		door_opened = false
		current_fram = 0#(current_fram-1) % num_frames
		$AnimatedSprite.set_frame(current_fram)
