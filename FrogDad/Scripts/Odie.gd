extends StaticBody2D

const PlayerClass = preload("res://Scripts/FrogDad.gd")
onready var FrogDad = get_tree().get_root().find_node("FrogDad", true, false)
var dialogue_finished = false
var mouse_in_area = false
var player_close_to_odie = false

func _ready():
	$AnimatedSprite.play("default")

# If the player is nearby, show the speech bubble
func _on_Interactable_body_entered(body):
	if body is PlayerClass && !dialogue_finished:
		$Speech.visible = true
		player_close_to_odie = true
	$AnimatedSprite.play("default")

# if the player has left, hide the speech bubble
func _on_Interactable_body_exited(body):
	if $Speech.visible && !dialogue_finished:
		$Speech.visible = false
		player_close_to_odie = false

# handles whether the mouse is on odie or not
func _on_ClickArea_mouse_entered():
	mouse_in_area = true

# handles whether the mouse is on odie or not
func _on_ClickArea_mouse_exited():
	mouse_in_area = false

func _on_ClickArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
		and event.button_index == BUTTON_LEFT \
		and event.pressed \
		and player_close_to_odie:
		MasterScript.odie_quest_active = true
		FrogDad.toggle_riddle_visibility([[{avatar = "odie", text = "I can be broken without being touched or seen. What am I?" }], {correct_answer = "Promise", wrong_answer1 = "Heart", wrong_answer2 = "My Legs )-:", question_name = "keyword"}])

