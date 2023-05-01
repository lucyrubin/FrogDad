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
		if MasterScript.began_odie_riddles and MasterScript.currentQuestNum == 6:
			FrogDad.toggle_dialogue_box_visibility([{avatar = "odie", text = "Back for more? Alright, pal."}], "coming back to odie")
		elif  MasterScript.currentQuestNum == 6:
			FrogDad.toggle_dialogue_box_visibility([{avatar = "frogDad", text = "Hey Odie!"}, 
			{avatar = "odie", text = "..."},
			{avatar = "frogDad", text = "... Hello?"},
			{avatar = "odie", text = "..."},
			{avatar = "frogDad", text = "..."},
			{avatar = "frogDad", text = "ODIE!!!"},
			{avatar = "odie", text = "Eh? Did you say something?"},
			{avatar = "frogDad", text = "Nevermind, I'll see you later, Odie."},
			{avatar = "odie", text = "No wait! My bird Mary-Beth has been my only company for weeks. I'm tired of her squawking. I need a change of pace."},
			{avatar = "odie", text = "You up for some riddles?"},
			{avatar = "frogDad", text = "Mmmmm... I'd rather not."},
			{avatar = "odie", text = "What if I told you..."},
			{avatar = "odie", text = "I have a prize?"},
			{avatar = "frogDad", text = "I'm listening..."},
			{avatar = "odie", text = "A little birdie told me you have some young whippersnappers in your house"},
			{avatar = "odie", text = "That little birdie being Mary-Beth - that is."},
			{avatar = "odie", text = "How would you like a state-of-the-art, electronic square device??"},
			{avatar = "frogDad", text = "You mean, a GameBoy??"},
			{avatar = "odie", text = "What? Don't be so sexist, FrogDad. Girls can be gamers too."},
			{avatar = "odie", text = "In fact, my lovely wife, Darla, rest her soul, was a gamer girl."},
			{avatar = "odie", text = "So whadda you say? Wanna play?"},
			{avatar = "frogDad", text = "Sure, why not?"}], "start riddle")
		else:
			FrogDad.toggle_dialogue_box_visibility([{avatar = "frogDad", text = "Hey Odie!"}, 
			{avatar = "odie", text = "..."},
			{avatar = "frogDad", text = "... Odie?"},
			{avatar = "odie", text = ".... oh Darla..."},
			{avatar = "odie", text = "... your shell... beautiful..."},
			{avatar = "odie", text = "... sooooo beautiful..."},
			{avatar = "frogDad", text = "I'm gonna go now..."},
			{avatar = "odie", text = "Yes, Darla I would love some more spaghetti... mmm... "}], "sleepy odie")
