extends Area2D

var current_fram = 0
var num_frames = 2

func _ready():
	#$Cloth/AnimatedSprite.visible = false
	pass
	

func _on_Dresser_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		current_fram = (current_fram +1) % num_frames
		$AnimatedSprite.set_frame(current_fram)
#		if current_fram == 1:
#			if $Cloth/AnimatedSprite != null:
#				$Cloth/AnimatedSprite.visible = true
#		else:
#			if $Cloth/AnimatedSprite != null:
#				$Cloth/AnimatedSprite.visible = false
			
