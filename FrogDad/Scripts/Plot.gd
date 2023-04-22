extends Panel

var current_fram = 3
var num_frames = 4

func _ready():
	$AnimatedSprite.z_index = rect_position.y

func _on_Plot_gui_input(event):
	if MasterScript.frog_dad_state =="":
		if event is InputEventMouseButton: 
				if event.button_index == BUTTON_LEFT and event.pressed:
					current_fram = (current_fram - 1)
					if current_fram == 0:
						$AnimatedSprite.visible = false
						$ItemDrop.visible = true
					else:
						$AnimatedSprite.set_frame(current_fram)

func _on_Plot_mouse_entered():
	if MasterScript.frog_dad_state =="":
		Input.set_custom_mouse_cursor(MasterScript.pointer)

func _on_Plot_mouse_exited():
	if MasterScript.frog_dad_state =="":
		Input.set_custom_mouse_cursor(MasterScript.hand)
