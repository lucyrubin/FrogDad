extends Node2D

func _on_CompletedButton_mouse_entered():
	Input.set_custom_mouse_cursor(MasterScript.pointer)

func _on_CompletedButton_mouse_exited():
	Input.set_custom_mouse_cursor(MasterScript.hand)
