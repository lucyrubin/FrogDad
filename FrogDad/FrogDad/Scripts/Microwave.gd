extends Area2D

var current_fram = 0
var num_frames = 2



func _on_Microwave_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		current_fram = (current_fram +1) % num_frames
		$AnimatedSprite.set_frame(current_fram)
