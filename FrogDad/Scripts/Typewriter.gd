extends Area2D

var current_fram = 0
var num_frames = 4
var in_area

func _on_Typewriter_input_event(_viewport, event, _shape_idx):
	if _left_click_in_area(event):
			current_fram = (current_fram +1) % num_frames
			$AnimatedSprite.set_frame(current_fram)
			$Typewriting.play()

func _on_Typewriter_mouse_entered():
	if MasterScript.frog_dad_state == "" and in_area:
		$AnimatedSprite.animation = "hover"
		$AnimatedSprite.set_frame(current_fram)
		Input.set_custom_mouse_cursor(MasterScript.pointer)
	
func _on_Typewriter_mouse_exited():
	if MasterScript.frog_dad_state == "":
		$AnimatedSprite.animation = "default"
		$AnimatedSprite.set_frame(current_fram)
		Input.set_custom_mouse_cursor(MasterScript.hand)
		
func _on_Typewriter_area_entered(area):
	if MasterScript.frog_dad_state == "":
		in_area = true

func _on_Typewriter_area_exited(area):
	if MasterScript.frog_dad_state == "":
		in_area = false

func _left_click_in_area(event):
	return event is InputEventMouseButton \
	and MasterScript.frog_dad_state == "" \
	and event.button_index == BUTTON_LEFT \
	and event.pressed \
	and in_area
