extends Node2D

var FrogDad_inventory
var FrogDad_inventory_data
var QuestContainerScene = preload("res://Scenes/QuestContainer.tscn")
var DoorScript = preload("res://Scripts/Door.gd")
var FrogDad 
var info_button_open
var SmallPopUpBoxScene = preload("res://Scenes/SmallPopUpBox.tscn")

onready var UserInterfaceNode = get_tree().get_root().find_node("UserInterface", true, false)
onready var HUDNode = get_tree().get_root().find_node("HUD", true, false)
onready var PopUpNode = UserInterfaceNode.get_node("SmallPopUpBox")


export (NodePath) var inventory_path


func _ready():
	FrogDad = get_tree().get_root().find_node("FrogDad", true, false)
	FrogDad_inventory = FrogDad.find_node("Inventory", true, false)
	FrogDad_inventory_data = FrogDad_inventory.inventory_data
	if MasterScript.currentQuestNum == -1 :
		begin_intro_quest()
	elif MasterScript.currentQuestNum == 0 and !MasterScript.opened_quest_first_time:
		after_note_appears()
		get_tree().get_root().find_node("ToggleQuestButton", true, false).get_node("BouncingArrow").visible = true
		## temporary to show the baby jar being carried
		FrogDad.get_node("BabyJar").visible = true
		## temporary to show the baby jar being carried
		
		HUDNode.new_quest("Make a Swaddle")
	elif MasterScript.after_eggs_to_tadpoles and !MasterScript.crib_dialogue_shown:
		PopUpNode.visible = true
		PopUpNode.show_dialog_box([{avatar = "", text = "Wow, they've grown up so fast, but now they're hungry all the time."},
								{avatar = "", text = "I better explore the neighborhood and find some food. I heard Jimothy John's is pretty good, maybe they'll have something!"}], "Finished cloth quest")
		MasterScript.crib_dialogue_shown = true
	elif MasterScript.currentQuestNum == 5:
		FrogDad.set_fly_jar_visiblity(true)
	elif MasterScript.currentQuestNum >= 6:
		FrogDad.set_fly_jar_visiblity(false)
		if MasterScript.currentQuestNum == 6 and !MasterScript.after_tadpoles_to_babies_dialogue_shown:
			MasterScript.after_tadpoles_to_babies_dialogue_shown = true
			PopUpNode.visible = true
			PopUpNode.show_dialog_box([{avatar = "", text = "Wow, they're already in pre school. The house feels so empty!"},
			{avatar = "", text = "What am I gonna do all day? I don't even remember my life before them..."},
			{avatar = "", text = "Maybe I should go explore the neighborhood... it's been a while since I've talked to my neighbors! I wonder how Odie is doing."}], "Talking to Odie")
		
func _process(delta):
	# can't do stuff while the intro is happening
	if get_tree().get_root().find_node("FrogDad", true, false) and MasterScript.currentQuestNum == -1: 
		MasterScript.frog_dad_state = "intro"
	
	

func deleteQuest(SubQuest):
	$CompleteSound.play()
	# remove quest from MasterScript.currentQuestArray
	FrogDad_inventory.removeItems(MasterScript.currentQuestArray[0][2], MasterScript.currentQuestArray[0][3])
	MasterScript.currentQuestArray.remove(0) # if we have concurrent requests this should be changed to MasterScript.currentQuestNum, not totally sure what else we would need to change though
	if MasterScript.questDictionary.size() > MasterScript.currentQuestNum + 1:
		MasterScript.currentQuestNum+=1
		MasterScript.currentQuestArray.append(MasterScript.questDictionary[MasterScript.currentQuestNum])

		# for testing: show the quest and sprite image as labels
		MasterScript.quest_state = MasterScript.currentQuestArray[0][1]
		MasterScript.sprite_image = MasterScript.currentQuestArray[0][4]
		
	# remove quest from GUI
	
	# hide quest GUI
	visible = false
	UserInterfaceNode.get_node("DarkBackground").visible = false
	MasterScript.frog_dad_state = ""
	
	
		
	## if you want to play dialogue after a quest is finshed, do it here
	if SubQuest and SubQuest.get_node("VBoxContainer/QuestTitleLabel").text == "Make a Swaddle":
		## temporary to show the baby jar being carried
		FrogDad.get_node("BabyJar").visible = false
		## temporary to show the baby jar being carried
		PopUpNode.visible = true
		# the second value of this is just an identifier for if you want to do something after dialogue has ended
		PopUpNode.show_dialog_box([{avatar = "", text = "This is perfect! Now they're safe and warm."},
								{avatar = "", text = "But this won't last forever... These babies are going to grow up soon and need somewhere to sleep."},
								{avatar = "", text = "There's a forest outside. Maybe I can get wood and make a cradle for them."}], "Finished cloth quest")
								
	if SubQuest and SubQuest.get_node("VBoxContainer/QuestTitleLabel").text == "Collect Logs for Crib":
		
		SceneTransition.change_scene("res://Scenes/CradleCutScene.tscn")
		
		
		
	
		
		
	
	SubQuest.queue_free()
								
		# the second value of this is just an identifier for if you want to do something after dialogue has ended
		
	## if you want to play dialogue after a quest is finshed, do it here

	
	
	
	
func collectResourceQuest(quest, amountRequired, itemType):
	amountRequired = int(amountRequired)
	# add a new quest to the GUI

	var SubQuest = QuestContainerScene.instance()
	$VBoxContainer.add_child(SubQuest)
	var CompletedButton = SubQuest.get_node("VBoxContainer/CompletedButton")
	CompletedButton.connect("pressed", self, "deleteQuest", [SubQuest])
	
	# count up the amount of the item in the inventory
	var totalItem = 0
	for item in FrogDad_inventory_data.inventory:
		if FrogDad_inventory_data.inventory[item][0] == itemType:
			totalItem += FrogDad_inventory_data.inventory[item][1]
	
	# update GUI based on amount in inventory
	SubQuest.get_node("VBoxContainer/GridContainer/DescriptionLabel").text = "Collect " + str(itemType) 
	SubQuest.get_node("VBoxContainer/GridContainer/Icon").texture = load("res://Item Icons/" + str(itemType) + ".png")
	SubQuest.get_node("VBoxContainer/GridContainer/AmountLabel").text = str(totalItem) + "/" + str(amountRequired) 
	SubQuest.get_node("VBoxContainer/QuestTitleLabel").text = quest
	

	# check if the requirements have been satisfied
	if totalItem >= amountRequired:
		CompletedButton.visible = true
	else: 
		CompletedButton.visible = false

func talkQuest(broad_quest, quest_details, character):
	# add a new quest to the GUI
	var SubQuest = QuestContainerScene.instance()
	$VBoxContainer.add_child(SubQuest)
	
	# count up the amount of the item in the inventory
	SubQuest.get_node("VBoxContainer/GridContainer/DescriptionLabel").text = quest_details
	SubQuest.get_node("VBoxContainer/GridContainer/Icon").texture = load("res://CharacterHeads/" + str(character) + "Head.png")
	SubQuest.get_node("VBoxContainer/QuestTitleLabel").text = broad_quest
	SubQuest.get_node("VBoxContainer/GridContainer/AmountLabel").text = ""
	SubQuest.get_node("VBoxContainer/CompletedButton").visible = false

func talkToKidsQuest(broad_quest, specific_task, item_type):
	var amount_required = 3
	
	var SubQuest = QuestContainerScene.instance()
	$VBoxContainer.add_child(SubQuest)
	
	# count up the amount of the item in the inventory
	SubQuest.get_node("VBoxContainer/GridContainer/DescriptionLabel").text = specific_task
	SubQuest.get_node("VBoxContainer/GridContainer/Icon").texture = load("res://Item Icons/" + str(item_type) + ".png")
	SubQuest.get_node("VBoxContainer/QuestTitleLabel").text = broad_quest
	SubQuest.get_node("VBoxContainer/GridContainer/AmountLabel").text = str(MasterScript.num_kids_fed_flies) + "/" + str(amount_required) 
	SubQuest.get_node("VBoxContainer/CompletedButton").visible = false
	
	
	#5: ["talk to kids", "Feed the kids", "Bring the flies home and give them to the kids", "Fly", "image_here"]
func resourceForCharacterQuest(quest, amountRequired, itemType):
	amountRequired = int(amountRequired)
	# add a new quest to the GUI

	var SubQuest = QuestContainerScene.instance()
	$VBoxContainer.add_child(SubQuest)
	var CompletedButton = SubQuest.get_node("VBoxContainer/CompletedButton")
	CompletedButton.connect("pressed", self, "deleteQuest", [SubQuest])
	
	# count up the amount of the item in the inventory
	var totalItem = 0
	for item in FrogDad_inventory_data.inventory:
		if FrogDad_inventory_data.inventory[item][0] == itemType:
			totalItem += FrogDad_inventory_data.inventory[item][1]
	
	# update GUI based on amount in inventory
	SubQuest.get_node("VBoxContainer/GridContainer/DescriptionLabel").text = "Collect " + str(itemType) 
	SubQuest.get_node("VBoxContainer/GridContainer/Icon").texture = load("res://Item Icons/" + str(itemType) + ".png")
	SubQuest.get_node("VBoxContainer/GridContainer/AmountLabel").text = str(totalItem) + "/" + str(amountRequired) 
	SubQuest.get_node("VBoxContainer/QuestTitleLabel").text = quest
	
	CompletedButton.visible = false

func close_quest():
	# remove all quests from the GUI
	for child in $VBoxContainer.get_children():
		child.queue_free()

	MasterScript.frog_dad_state = ""

func _on_ToggleQuestButton_pressed():
	Input.set_custom_mouse_cursor(MasterScript.hand)
	if MasterScript.frog_dad_state == "":
		if !MasterScript.opened_quest_first_time:
				MasterScript.opened_quest_first_time = true
		if 	get_tree().get_root().find_node("ToggleQuestButton", true, false).get_node("BouncingArrow").visible:
				get_tree().get_root().find_node("ToggleQuestButton", true, false).get_node("BouncingArrow").visible = false

		visible = true
		UserInterfaceNode.get_node("DarkBackground").visible = true
		MasterScript.frog_dad_state = "quest"

		# add all current quests to the GUI
		for quest in MasterScript.currentQuestArray:
			if quest[0] == "resource collection":
				collectResourceQuest(quest[1], quest[2], quest[3])
			elif quest[0] == "talk":
				talkQuest(quest[1], quest[2], quest[3])
			elif quest[0] == "resource for character":
				resourceForCharacterQuest(quest[1], quest[2], quest[3])
			elif quest[0] == "talk to kids":
				talkToKidsQuest(quest[1], quest[2], quest[3])

		if MasterScript.currentQuestArray.empty():
			var noQuestLabel = Label.new()
			noQuestLabel.text = "No active quests."
			var dynamic_font = DynamicFont.new()
			dynamic_font.size = 60
			dynamic_font.font_data = load("res://Fonts/Aaxiaolongti.ttf")
			noQuestLabel.add_font_override("font", dynamic_font)
			noQuestLabel.add_color_override("font_color", Color(0,0,0,1))
			$VBoxContainer.add_child(noQuestLabel)
		
		MasterScript.frog_dad_state = "Quest"


func check_if_quest_fulfilled():
	# add all current quests to the GUI
	for quest in MasterScript.currentQuestArray:
		if quest[0] == "resource collection":
			# count up the amount of the item in the inventory
			var item_type = quest[3]
			var totalItem = count_num_item_in_inventory(item_type)
			var amountRequired = quest[2]
					
			# check if the requirements have been satisfied, if they have, show the arrow
			if totalItem >= amountRequired: 
				get_tree().get_root().find_node("ToggleQuestButton", true, false).get_node("BouncingArrow").visible = true
		elif quest[0] == "resource for character":
			# count up the amount of the item in the inventory
			var item_type = quest[3]
			var totalItem = count_num_item_in_inventory(item_type)
			var amountRequired = quest[2]
					
			# check if the requirements have been satisfied, if they have, start a new quest
			if totalItem >= amountRequired: 
				PopUpNode.visible = true
				PopUpNode.show_dialog_box([{avatar = "", text = "Woohoo! I got the lettuce. Now I gotta bring this back to Jimothy."}],
					"Finished collecting lettuce")
		elif quest[0] == "talk to kids":
					
			# check if the requirements have been satisfied, if they have, start a new quest
			if MasterScript.num_kids_fed_flies == 3: 
				PopUpNode.visible = true
				FrogDad.set_fly_jar_visiblity(false)
				PopUpNode.show_dialog_box([{avatar = "", text = "Phew! They have been fed. Oh my goodness, they are going to grow up soon. Time flies."}],
					"Finished feeding flies")
					
				
				

# count up the amount of the item in the inventory				
func count_num_item_in_inventory(itemType):
	var totalItem = 0
	for item in FrogDad_inventory_data.inventory:
		if FrogDad_inventory_data.inventory[item][0] == itemType:
			totalItem += FrogDad_inventory_data.inventory[item][1]
	return totalItem
func begin_intro_quest():
	PopUpNode.visible = true
	PopUpNode.show_dialog_box([{avatar = "", text = "Ahhhh. Another day all alone..." }, {avatar = "", text = "Every day feels the same."}, {avatar = "", text = "I wake up..."}, {avatar = "", text = "I work as a freelance writer..."}, {avatar = "", text = "and I sleep."}, {avatar = "", text = "I wish something more exciting would happen..."}], "Another day")

	var door_node = get_tree().get_root().find_node("Door", true, false)
	if door_node:
		door_node.set_locked(true)
	get_parent().visible = false

func _on_KnockTimer_timeout():
	# this code creates and displays a dialogue box
	MasterScript.music_position = BackgroundMusic.get_playback_position()
	BackgroundMusic.stop()
	$KnockingSound.play()

	PopUpNode.visible = true
	PopUpNode.show_dialog_box([{avatar = "", text = "*Knock knock*"}], "Knock knock")

	$KnockingSound.stop()
	BackgroundMusic.play(MasterScript.music_position)
	$KnockTimer.queue_free()

func after_note_appears():
	get_parent().visible = false
	var toggleQuestButton = get_tree().get_root().find_node("ToggleQuestButton", true, false)
	toggleQuestButton.visible = true
