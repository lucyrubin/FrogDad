extends KinematicBody2D

# script that all babies use
export (String) var baby_name
const PlayerClass = preload("res://Scripts/FrogDad.gd")
onready var FrogDad = get_tree().get_root().find_node("FrogDad", true, false)
onready var QuestNode = get_tree().get_root().find_node("Quest", true, false)
var dialogue_finished = false
var mouse_in_area = false
var player_close_to_baby = false

# when gertude is clicked, open the dialogue box
func _input(event):
	if event.is_action_pressed("talk") and mouse_in_area and player_close_to_baby:
		if baby_name == "Gertrude":
			FrogDad.toggle_dialogue_box_visibility([{avatar = "gertrude", text = "Hi Frog Dad!"},
				{avatar = "frogDad", text = "Hi Gertrude!"},
				{avatar = "gertrude", text = "What are we doing today?"},
				{avatar = "frogDad", text = "Whatever you want."}
			], "Gertrude talk")
			if MasterScript.currentQuestNum == 5 and !MasterScript.gertrude_fed:
				MasterScript.num_kids_fed_flies += 1
				MasterScript.gertrude_fed = true
				var FlyJarParticle = FrogDad.get_node("FlyJar").get_node("Flies")
				FrogDad.toggle_dialogue_box_visibility([{avatar = "gertrude", text = "Yum!"}
				], "Gertrude fed")
				FlyJarParticle.visible = true

			elif MasterScript.currentQuestNum == 5 and MasterScript.gertrude_fed:
				FrogDad.toggle_dialogue_box_visibility([{avatar = "gertrude", text = "No more flies, I'm stuffed!"}
				], "Gertrude already fed")

		if baby_name == "Gilbert":
			FrogDad.toggle_dialogue_box_visibility([{avatar = "gilbert", text = "Hi dada"},
					{avatar = "frogDad", text = "Hi Gilbert!"},
					{avatar = "gilbert", text = "Hiiiiii"},
					{avatar = "frogDad", text = "Hi :)"}
				], "Gilbert talk")
			if MasterScript.currentQuestNum == 5 and !MasterScript.gilbert_fed:
				MasterScript.num_kids_fed_flies += 1
				MasterScript.gilbert_fed = true
				var FlyJarParticle = FrogDad.get_node("FlyJar").get_node("Flies")
				FrogDad.toggle_dialogue_box_visibility([{avatar = "gilbert", text = "Dis is da best ting ever tasted!"}
				], "gilbert fed")
				FlyJarParticle.visible = true

			elif MasterScript.currentQuestNum == 5 and MasterScript.gilbert_fed:
				FrogDad.toggle_dialogue_box_visibility([{avatar = "gilbert", text = "I'm full!"}
				], "Gilbert already fed")
		
		if baby_name == "Gravy Baby":
			FrogDad.toggle_dialogue_box_visibility([{avatar = "gravy", text = "Gravy!"},
					{avatar = "frogDad", text = "Yes, you are Gravy. "},
					{avatar = "gravy", text = "I'm Gravy Baby."},
					{avatar = "frogDad", text = "Yes :)"}
				], "Gravy talk")
			if MasterScript.currentQuestNum == 5 and !MasterScript.gravy_fed:
				MasterScript.num_kids_fed_flies += 1
				MasterScript.gravy_fed = true
				var FlyJarParticle = FrogDad.get_node("FlyJar").get_node("Flies")
				FrogDad.toggle_dialogue_box_visibility([{avatar = "gravy", text = "aaaaaaaaaaaaa :P"}
				], "gravy fed")
				FlyJarParticle.visible = true
				
			elif MasterScript.currentQuestNum == 5 and MasterScript.gravy_fed:
				FrogDad.toggle_dialogue_box_visibility([{avatar = "gravy", text = "Noooooooooo"}
				], "gravy already fed")
		
		MasterScript.frog_dad_state = "dialogue"
		FrogDad.get_node("AnimatedSprite").stop()
		$Speech.visible = false
	
# Handles whether the mouse is on Gertrude or not
func _on_ClickArea_mouse_entered():
	if player_close_to_baby:
		mouse_in_area = true
		Input.set_custom_mouse_cursor(MasterScript.pointer)

# Handles whether the mouse is on Gertrude or not
func _on_ClickArea_mouse_exited():
	if player_close_to_baby:
		mouse_in_area = false
		Input.set_custom_mouse_cursor(MasterScript.hand)

# if player is nearby, show the action bubble
func _on_Interactable_body_entered(body):
	if body is PlayerClass && !dialogue_finished:
		$Speech.visible = true
		player_close_to_baby = true
	$AnimatedSprite.play("default")

# if the player has left, hide the action bubble
func _on_Interactable_body_exited(_body):
	if $Speech.visible && !dialogue_finished:
		$Speech.visible = false
		player_close_to_baby = false
