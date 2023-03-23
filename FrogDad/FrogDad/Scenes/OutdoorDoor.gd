extends Area2D

export (PackedScene) var target_scene = load("res://Scenes/Main.tscn")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		print(get_overlapping_bodies().size())
		if !target_scene:
			print("no scene in this door")
			
		if get_overlapping_bodies().size()>0:
			go_outside()
			#this works for now but worried it may cause issues in future

func go_outside():
		var ERR = get_tree().change_scene_to(target_scene)
		if ERR != OK:
			print("something failed in the door scene")
