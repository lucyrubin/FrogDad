extends Area2D

onready var frogdad_node = get_tree().get_root().find_node("FrogDad",true, false)

var TVScene = "res://Scenes/TV.tscn"
var mouse_in
var in_area

func _ready():
	in_area = false
	mouse_in = false

func _on_TV_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and frogdad_node.state == "":
		if in_area and mouse_in:
			SceneTransition.change_scene(TVScene)

func _on_TV_area_entered(area):
	if frogdad_node.state == "":
		in_area = true
		$AnimatedSprite.animation = "hover"

func _on_TV_area_exited(area):
	if frogdad_node.state == "":
		in_area = false
		$AnimatedSprite.animation = "default"

func _on_TV_mouse_entered():
	if frogdad_node.state == "":
		mouse_in = true
		$AnimatedSprite.animation = "hover"

func _on_TV_mouse_exited():
	if frogdad_node.state == "":
		mouse_in = false
		$AnimatedSprite.animation = "default"
