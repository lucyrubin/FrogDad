extends Area2D

#var current_fram = 0
#var num_frames = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Sink_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		#current_fram = (current_fram +1) % num_frames
		$AnimatedSprite.play("default")
		#$AnimatedSprite.set_frame(current_fram)
