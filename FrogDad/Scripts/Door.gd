extends Area2D

export (PackedScene) var target_scene = load("res://Scenes/Outdoors.tscn")
var door_opened = false
var current_fram = 0
var num_frames = 2

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if !target_scene:
			print("no scene in this door")
		if door_opened:
			go_outside()

func go_outside():
		var ERR = get_tree().change_scene_to(target_scene)
		if ERR != OK:
			print("something failed in the door scene")

func _on_Door_area_entered(area):
	door_opened = true
	current_fram = (current_fram +1) % num_frames
	$AnimatedSprite.set_frame(current_fram)

func _on_Door_area_exited(area):
	door_opened = false
	current_fram = (current_fram-1) % num_frames
	$AnimatedSprite.set_frame(current_fram)
