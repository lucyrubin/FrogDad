extends Area2D

var current_fram = 0
var num_frames = 2
onready var frogdad_node = get_tree().get_root().find_node("FrogDad",true, false)

func _on_Sink_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and MasterScript.frog_dad_state =="" \
	and event.button_index == BUTTON_LEFT and event.pressed:
		current_fram = (current_fram +1) % num_frames
		$AnimatedSprite.set_frame(current_fram)
		if $AnimatedSprite.get_frame() == 1:
			$AnimatedSprite/FaucetRunning.play()
		else:
			$AnimatedSprite/FaucetRunning.stop()
