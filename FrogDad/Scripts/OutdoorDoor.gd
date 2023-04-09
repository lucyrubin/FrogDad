extends Area2D

export (PackedScene) var target_scene = load("res://Scenes/Main.tscn")

var door_opened
var current_fram = 0
var num_frames = 2
var mouse_in = false

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

func _on_OutdoorDoor_area_entered(area):
	door_opened = true
	current_fram += 1
	$AnimatedSprite.set_frame(current_fram)

func _on_OutdoorDoor_area_exited(area):
	door_opened = false
	current_fram -= 1
	$AnimatedSprite.set_frame(current_fram)
	
func _on_Area2D_mouse_entered():
	$AnimatedSprite.play("hover")
	mouse_in = true

func _on_Area2D_mouse_exited():
	$AnimatedSprite.play("close")
	mouse_in = false
