extends Area2D

var current_fram = 0
var num_frames = 2
onready var frogdad_node = get_tree().get_root().find_node("FrogDad",true, false)

func _ready():
	$AnimatedSprite.animation = "default"

func _on_Side_Table_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and frogdad_node.state ==""\
	and event.button_index == BUTTON_LEFT and event.pressed:
		current_fram = (current_fram +1) % num_frames
		$AnimatedSprite.set_frame(current_fram)

func _on_Side_Table_area_entered(area):
	$AnimatedSprite.animation = "hover"
	$AnimatedSprite.set_frame(current_fram)

func _on_Side_Table_area_exited(area):
	$AnimatedSprite.animation = "default"
	$AnimatedSprite.set_frame(current_fram)

func _on_Side_Table_mouse_entered():
	$AnimatedSprite.animation = "hover"
	$AnimatedSprite.set_frame(current_fram)


func _on_Side_Table_mouse_exited():
	$AnimatedSprite.animation = "default"
	$AnimatedSprite.set_frame(current_fram)
