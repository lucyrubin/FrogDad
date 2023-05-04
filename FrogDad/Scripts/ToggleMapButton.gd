extends TextureButton




func _on_ToggleMapButton_mouse_entered():
	if MasterScript.frog_dad_state == "":
		Input.set_custom_mouse_cursor(MasterScript.pointer)
		texture_normal = load("res://Info Icons/map icon hover.png")


func _on_ToggleMapButton_mouse_exited():
	if MasterScript.frog_dad_state == "":
		Input.set_custom_mouse_cursor(MasterScript.hand)
		texture_normal = load("res://Info Icons/map icon normal.png")
