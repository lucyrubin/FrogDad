extends Area2D

export (PackedScene) var target_scene = load("res://Scenes/Main.tscn")
var door_opened

func _input(event):
	if event.is_action_pressed("open"):
		if !target_scene:
			print("no scene in this door")
		if door_opened:
			go_inside()
			#this works for now but worried it may cause issues in future

func go_inside():
		var ERR = get_tree().change_scene_to(target_scene)
		if ERR != OK:
			print("something failed in the door scene")


func _on_OutdoorDoor_area_entered(area):
	door_opened = true


func _on_OutdoorDoor_area_exited(area):
	door_opened = false
