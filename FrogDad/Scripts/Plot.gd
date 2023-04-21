extends Panel

#var current_fram = 0
var current_fram = 3
var num_frames = 4


func _on_Plot_gui_input(event):
	if event is InputEventMouseButton: 
			if event.button_index == BUTTON_LEFT and event.pressed:
				current_fram = (current_fram - 1)
				if current_fram == 0:
					$AnimatedSprite.visible = false
					$ItemDrop.visible = true
				else:
					$AnimatedSprite.set_frame(current_fram)
