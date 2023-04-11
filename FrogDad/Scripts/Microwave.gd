extends Area2D

var current_fram = 0
var num_frames = 2


func _ready():
	$AnimatedSprite.animation = "default"

func _on_Microwave_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and MasterScript.FrogDad.state =="" \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		current_fram = (current_fram +1) % num_frames
		$AnimatedSprite.set_frame(current_fram)

func _on_Microwave_mouse_entered():
	if MasterScript.FrogDad.state =="":
		$AnimatedSprite.animation = "hover"
		$AnimatedSprite.set_frame(current_fram)

func _on_Microwave_mouse_exited():
	if MasterScript.FrogDad.state =="":
		$AnimatedSprite.animation = "default"
		$AnimatedSprite.set_frame(current_fram)

func _on_Microwave_area_entered(area):
	if MasterScript.FrogDad.state =="":
		$AnimatedSprite.animation = "hover"
		$AnimatedSprite.set_frame(current_fram)

func _on_Microwave_area_exited(area):
	if MasterScript.FrogDad.state =="":
		$AnimatedSprite.animation = "default"
		$AnimatedSprite.set_frame(current_fram)
