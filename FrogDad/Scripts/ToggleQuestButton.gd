extends TextureButton

func _on_ToggleQuestButton_mouse_entered():
	if MasterScript.frog_dad_state == "":
		Input.set_custom_mouse_cursor(MasterScript.pointer)

func _on_ToggleQuestButton_mouse_exited():
	if MasterScript.frog_dad_state == "":
		Input.set_custom_mouse_cursor(MasterScript.hand)
