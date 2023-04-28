extends CanvasLayer

const AVATAR_MAP = {
	"gertrude": preload("res://Temporary Clipart/gertrude copy (1).png"),
	"frogDad": preload("res://Temporary Clipart/frog_dad_icon.png"),
	"jimothy": preload("res://CharacterHeads/JimothyHead.png"),
	"gilbert": preload("res://CharacterHeads/gilberthead.png"),
	"gravy": preload("res://CharacterHeads/gravyhead.png"),
	"odie": preload("res://CharacterHeads/odiehead.png")
}

export var interval = 0.05 # interval betext_animation when each character shows up

var dialogs = []
var current = 0

onready var content = $Content
onready var next_indicator = $Content/NextIndicator
onready var text_animation = $Content/TextAnimation
onready var avatar 
onready var FrogDad = get_tree().get_root().find_node("FrogDad", true, false)

var completed
var dialogue_name
var paused_for_riddle = false
var current_riddle 

func _input(event):
	# if user pressed "space key" before text animation ends,
	# the animation would be skipped and all text would show
	if event.is_action_pressed("open") and content.visible:
		print("click")
		if !paused_for_riddle:
			if FrogDad:
				MasterScript.frog_dad_state= "talking" # player can't move during dialogue
			if text_animation.is_active():
				text_animation.remove_all()
				content.percent_visible = 1
				_on_TextAnimation_tween_all_completed()
			elif current + 1 < dialogs.size():
					_show_dialog(current + 1)
			else:
				hide_dialog_box()
				
	if event.is_action_pressed("ui_cancel"):
		hide_dialog_box()

func hide_dialog_box():
	if FrogDad:
		MasterScript.frog_dad_state = "" # player can move again

	content.hide()
	completed = true
	$ColorRect.hide()

	if find_node("RiddleHUD", true, false):
		$RiddleHUD.visible = false
	##
	##
	##
	# If you want to do something after a dialogue, do it here
	# this code handles what should happen after a dialogue finished
	if MasterScript.currentQuestNum == -1 and dialogue_name == "Another day": 
		# after ahhh another day
		get_tree().get_root().find_node("KnockTimer", true, false).start()
	elif dialogue_name == "Knock knock":
		# after knock knock
		SceneTransition.change_scene("res://Scenes/NoteCutScene.tscn")
	elif dialogue_name == "Wow, someone trusted me with their babies?":
		# after babies cut scene
		MasterScript.findBabies = true
		SceneTransition.change_scene("res://Scenes/Main.tscn")
	elif dialogue_name == "Finished cloth quest": 
		## after finished cloth quest dialouge
		show_new_quest_notifcation_box()
	elif dialogue_name == "Finished log quest":
		show_new_talk_quest_notification_box()
	elif dialogue_name == "jimothy first talk":
		MasterScript.currentQuestNum+=1
		MasterScript.currentQuestArray = [MasterScript.questDictionary[3]]
		show_new_quest_notifcation_box()

	# If you want to do something after a dialogue, do it here

func show_new_talk_quest_notification_box():
	var HUDNode = FrogDad.find_node("HUD", true, false)
	HUDNode.new_quest(MasterScript.currentQuestArray[0][2])

func show_new_quest_notifcation_box():
	var HUDNode = FrogDad.find_node("HUD", true, false)
	HUDNode.new_quest(MasterScript.currentQuestArray[0][1])

func show_dialog_box(_dialogs, dialogueName):
	$ColorRect.show()
	dialogue_name = dialogueName

	if FrogDad:
		MasterScript.frog_dad_state = "talking" # player can't move during dialogue

	completed = false
	content = $Content
	next_indicator = $Content/NextIndicator
	text_animation = $Content/TextAnimation

	if $Content.get_node("Avatar"):
		avatar = $Content/Avatar

	dialogs = _dialogs
	content.show()
	_show_dialog(0)

func _show_dialog(index):
	if FrogDad:
		MasterScript.frog_dad_state= "talking" # player can't move during dialogue

	current = index
	var dialog = dialogs[current]
	content.text = dialog.text

	if dialog.avatar != "":
		avatar.texture = AVATAR_MAP[dialog.avatar]
	
	next_indicator.hide()
	text_animation.interpolate_property(
		content, "percent_visible", 0, 1, 
		interval * content.text.length(),
		text_animation.TRANS_LINEAR
	)
	text_animation.start()

func _on_TextAnimation_tween_all_completed():
	if !MasterScript.odie_quest_active:
		next_indicator.show()
	else: 
		if(get_node("RiddleHUD")):
			$RiddleHUD.visible = true
			$RiddleHUD/VBoxContainer.visible = true
			paused_for_riddle = true

# [{question, correct_answer : , wrong_answer1: , wrong_answer2: , question_name : ]
func play_riddle (riddle):
	current_riddle = riddle
	show_dialog_box(riddle[0], riddle[1].question_name)
	
	var options = [riddle[1].correct_answer, riddle[1].wrong_answer1, riddle[1].wrong_answer2]
	
	var rng = RandomNumberGenerator.new()
	
	rng.randomize()
	var rand_int = rng.randi_range(0, options.size()-1)#(randi() % options.size()) - 1
	$RiddleHUD/VBoxContainer/Option1.set_text(options[rand_int])
	options.remove(rand_int)
	
	rng.randomize()
	rand_int = rng.randi_range(0, options.size()-1)
	$RiddleHUD/VBoxContainer/Option2.set_text(options[rand_int])
	options.remove(rand_int)
	
	rng.randomize()
	rand_int = rng.randi_range(0, options.size()-1)
	$RiddleHUD/VBoxContainer/Option3.set_text(options[rand_int])
	options.remove(rand_int)

func _on_Option1_pressed():
	_update_riddle($RiddleHUD/VBoxContainer/Option1)

func _on_Option2_pressed():
	_update_riddle($RiddleHUD/VBoxContainer/Option2)

func _on_Option3_pressed():
	_update_riddle($RiddleHUD/VBoxContainer/Option3)

func _update_riddle(button):
	$RiddleHUD/VBoxContainer.visible = false
	if button.text == current_riddle[1].correct_answer:
		if button.text == "Promise":
			show_dialog_box([{avatar = "odie", text = "That was right!."},], "promise was right")
			play_riddle([[{avatar = "odie", text = "What flies when it's born, lies when it's alive, and runs when it's dead?" }],
			{correct_answer = "A snowflake", wrong_answer1 = "A fly?", wrong_answer2 = "Lies when it's alive? That's my ex wife!", question_name = "keyword"}])
		if button.text == "A snowflake":
			play_riddle([[{avatar = "odie", text = "What is always coming but never arrives?" }],
			{correct_answer = "Tomorrow", wrong_answer1 = "My next paycheck!", wrong_answer2 = "My SnailMail food delivery", question_name = "keyword"}])
	else:
		MasterScript.odie_quest_active = false
		paused_for_riddle = false
		if button.text == "Heart":
			show_dialog_box([{avatar = "odie", text = "Tis better to have loved and lost, than to never have loved at all… I learned that from the back of a napkin at Jimothy John’s. Pretty good, right?"},
				{avatar = "frogDad", text = "... )-:"},
				{avatar = "odie", text = "What? Why are you looking at me like that?"},
				{avatar = "odie", text = "..."},
				{avatar = "odie", text = "Are you crying? I'm sorry, buddy."}], "heart")
		elif button.text == "My Legs )-:":
			show_dialog_box([{avatar = "odie", text = "What? No. Try again!"},], "my legs")
		elif button.text == "A fly?":
			show_dialog_box([{avatar = "odie", text = "Nice try. I did know a fly who liked to lie. He was a conniving son of a birch! Did I ever tell you the story about-"},
				{avatar = "frogDad", text = "I'm gonna stop you right there, pal. I think I left my stove on, catch you later!"},
				{avatar = "odie", text = "What? Okay. Well, let me know if you wanna try again!"}], "A fly?")
		elif button.text == "Lies when it's alive? That's my ex wife!":
			show_dialog_box([{avatar = "odie", text = "Oh... that's just sad. Sorry, bud. Try again next time?"},], "My ex wife")
		elif button.text == "My next paycheck!":
			show_dialog_box([{avatar = "odie", text = "Haha! Good one, but not what I was looking for! You can always try again, though."},], "My paycheck")
		elif button.text == "My SnailMail food delivery":
			show_dialog_box([{avatar = "odie", text = "Huh? Food delivery? What's that?"},], "Snailmail")
