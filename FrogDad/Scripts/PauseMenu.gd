extends Control


func _input(event):
	if event.is_action_pressed("pause"):
		show_menu()

func show_menu():
	show()

func hide_menu():
	hide()

func _on_ResumeButton_pressed():
	hide_menu()

func _on_QuitButton_pressed():
	hide_menu()
	get_tree().quit()

func _on_PauseMenu_visibility_changed():
	MasterScript.game_paused = visible
	get_tree().paused = visible

func _on_ResumeButton_mouse_entered():
	Input.set_custom_mouse_cursor(MasterScript.pointer)

func _on_ResumeButton_mouse_exited():
	Input.set_custom_mouse_cursor(MasterScript.hand)

func _on_QuitButton_mouse_entered():
	Input.set_custom_mouse_cursor(MasterScript.pointer)

func _on_QuitButton_mouse_exited():
	Input.set_custom_mouse_cursor(MasterScript.hand)
