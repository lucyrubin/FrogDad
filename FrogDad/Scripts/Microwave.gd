extends Area2D

var current_fram = 0
var num_frames = 2
onready var frogdad_node = get_tree().get_root().find_node("FrogDad",true, false)

func _ready():
	$AnimatedSprite.animation = "default"

func _on_Microwave_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and MasterScript.frog_dad_state =="" \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		current_fram = (current_fram +1) % num_frames
		$AnimatedSprite.set_frame(current_fram)

func _on_Microwave_mouse_entered():
	if MasterScript.frog_dad_state =="":
#		$AnimatedSprite.animation = "hover"
		$AnimatedSprite.set_frame(current_fram)

func _on_Microwave_mouse_exited():
	if MasterScript.frog_dad_state =="":
		$AnimatedSprite.animation = "default"
		$AnimatedSprite.set_frame(current_fram)

