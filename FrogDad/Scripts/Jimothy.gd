extends StaticBody2D

const PlayerClass = preload("res://Scripts/FrogDad.gd")

var done_talking = false
var mouse_in_area = false
onready var FrogDad = get_tree().get_root().find_node("FrogDad", true, false)
var already_talked_about_wanting_flies = false

func _on_InteractableArea_body_entered(body):
	
	if body is PlayerClass && !done_talking:
		$Speech.visible = true
		Input.set_custom_mouse_cursor(MasterScript.pointer)
	#$AnimatedSprite.play("default")

# if the player has left, hide the action bubble
func _on_InteractableArea_body_exited(_body):
	if $Speech.visible && !done_talking:
		$Speech.visible = false
		Input.set_custom_mouse_cursor(MasterScript.hand)

# change this to be the sprite eventually 
func _on_ColorRect_gui_input(event):
	if event is InputEventMouseButton and $Speech.visible:
		if event.button_index == BUTTON_LEFT && event.pressed: 
			if MasterScript.currentQuestNum < 2:
				FrogDad.toggle_dialogue_box_visibility([{avatar = "jimothy", text = "Hey bro, we're not open right now. Come back later."}]
				, "jimothy remind about lettuce")
			elif MasterScript.currentQuestNum == 2:
				FrogDad.toggle_dialogue_box_visibility([{avatar = "jimothy", text = "Welcome to Jimothy John's! What can I get for you today?"},
				{avatar = "frogDad", text = "Got anything with flies?"},
				{avatar = "jimothy", text = "Hell yeah we do!"}, 
				{avatar = "jimothy", text = "We got fly pies, flyjitas, fly alla parmigiana, flylafel, french flies... "}, 
				{avatar = "jimothy", text = "Add a drink and you can make it a combo!"},
				{avatar = "frogDad", text = "Wow! All of that sounds good, but... On second thought, could I just get a jar of flies?"}, 
				{avatar = "frogDad", text = "They're for my frog babies"},
				{avatar = "jimothy", text = "BABIES?!"}, 
				{avatar = "jimothy", text = "Like, more than one? Dang, Frog Guy."},
				{avatar = "frogDad", text = "It's Frog Dad now. And yeah, I have three."},
				{avatar = "jimothy", text = "Respect, bro."},
				{avatar = "jimothy", text = "Hey, since you're a single dad and all, I'll cut you a deal."},
				{avatar = "jimothy", text = "I've been needing to harvest some lettuce out in the lettuce forest."}, 
				{avatar = "jimothy", text = "Go get some for me and I'll get you your flies!"}
				], "jimothy first talk")
			elif MasterScript.currentQuestNum == 3:
				FrogDad.toggle_dialogue_box_visibility([{avatar = "jimothy", text = "If you get me some lettuce, I'd be happy to give you flies."}]
				, "jimothy remind about lettuce")
			elif MasterScript.currentQuestNum == 4:
				FrogDad.toggle_dialogue_box_visibility([{avatar = "jimothy", text = "YAS!!!! Now I don't need to take the trip to the lettuce forest. Thanks bro!!"}, 
				{avatar = "frogDad", text = "About the flies...."},
				{avatar = "jimothy", text = "Oh snap! I almost forgot haha."}, 
				{avatar = "jimothy", text = "Sure thing, my guy!"}]
				, "jimothy gives flies")
				var frog_dad_inventory = get_tree().get_root().find_node("Inventory", true, false)
				frog_dad_inventory.removeItems(10, "Lettuce")
				
			MasterScript.frog_dad_state = "dialogue"
			FrogDad.get_node("AnimatedSprite").stop()
			$Speech.visible = false

