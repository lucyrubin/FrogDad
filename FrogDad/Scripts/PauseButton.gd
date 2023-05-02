extends TextureButton

func _on_PauseButton_mouse_entered():
	
	Input.set_custom_mouse_cursor(MasterScript.pointer)

func _on_PauseButton_mouse_exited():
	
	Input.set_custom_mouse_cursor(MasterScript.hand)
