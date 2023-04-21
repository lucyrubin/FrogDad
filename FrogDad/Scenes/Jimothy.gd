extends StaticBody2D

const PlayerClass = preload("res://Scripts/FrogDad.gd")

var done_talking = false
var mouse_in_area = false
onready var FrogDad = get_tree().get_root().find_node("FrogDad", true, false)





func _on_InteractableArea_body_entered(body):
	
	if body is PlayerClass && !done_talking:
		$Speech.visible = true
	#$AnimatedSprite.play("default")

# if the player has left, hide the action bubble
func _on_InteractableArea_body_exited(body):
	if $Speech.visible && !done_talking:
		$Speech.visible = false




# change this to be the sprite eventually 
func _on_ColorRect_gui_input(event):
	if event is InputEventMouseButton and $Speech.visible:
		if event.button_index == BUTTON_LEFT && event.pressed: 
			FrogDad.toggle_dialogue_box_visibility([{avatar = "gertrude", text = "Yoyoyoyo Frog Dad!"},
			{avatar = "frogDad", text = "Hi Jimbo!"},
			{avatar = "gertrude", text = "food?"},
			{avatar = "frogDad", text = "yuh"}
		], "jimothy first talk")
			FrogDad.state = "dialogue"
			FrogDad.get_node("AnimatedSprite").stop()
			$Speech.visible = false

