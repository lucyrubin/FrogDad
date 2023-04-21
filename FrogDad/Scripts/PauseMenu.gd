extends Control


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
	get_tree().paused = visible
