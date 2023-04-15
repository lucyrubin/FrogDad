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
		yield(get_tree().create_timer(1.0), "timeout")
		begin_intro_quest()
	elif MasterScript.currentQuestNum == 0:
		after_note_appears()
		HUDNode.new_quest("Make a Swaddle")
		if !MasterScript.opened_quest_first_time:
			MasterScript.opened_quest_first_time = true
	

		

func deleteQuest(SubQuest):
	# remove quest from MasterScript.currentQuestArray

	FrogDad_inventory.removeItems(MasterScript.currentQuestArray[0][2], MasterScript.currentQuestArray[0][3])
	MasterScript.currentQuestArray.remove(0) # if we have concurrent requests this should be changed to MasterScript.currentQuestNum, not totally sure what else we would need to change though
	if MasterScript.questDictionary.size() > MasterScript.currentQuestNum + 1:
		MasterScript.currentQuestNum+=1
		MasterScript.currentQuestArray.append(MasterScript.questDictionary[MasterScript.currentQuestNum])

		# for testing: show the quest and sprite image as labels
		MasterScript.quest_state = MasterScript.currentQuestArray[0][1]
		MasterScript.sprite_image = MasterScript.currentQuestArray[0][4]
		print(MasterScript.currentQuestArray[0][1])
		HUDNode.new_quest(MasterScript.currentQuestArray[0][1])
	
	# remove quest from GUI
	SubQuest.queue_free()
	_on_ToggleQuestButton_pressed()
	
	
	
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

func _on_ToggleQuestButton_pressed():
	if 	get_tree().get_root().find_node("ToggleQuestButton", true, false).get_node("BouncingArrow").visible:
			get_tree().get_root().find_node("ToggleQuestButton", true, false).get_node("BouncingArrow").visible = false
	if !info_button_open:
		visible = !visible
		if visible:
			# add all current quests to the GUI
			for quest in MasterScript.currentQuestArray:
				if quest[0] == "resource collection":
					collectResourceQuest(quest[1], quest[2], quest[3])
			
			if MasterScript.currentQuestArray.empty():
				var noQuestLabel = Label.new()
				noQuestLabel.text = "No active quests."
				var dynamic_font = DynamicFont.new()
				dynamic_font.size = 60
				dynamic_font.font_data = load("res://Fonts/Aaxiaolongti.ttf")
				noQuestLabel.add_font_override("font", dynamic_font)
				noQuestLabel.add_color_override("font_color", Color(0,0,0,1))
				$VBoxContainer.add_child(noQuestLabel)
				
			FrogDad.state = "Quest"
		else:
			# remove all quests from the GUI
			for child in $VBoxContainer.get_children():
				child.queue_free()
			
			FrogDad.state = ""


func begin_intro_quest():
	PopUpNode.visible = true
	PopUpNode.show_dialog_box([{avatar = "", text = "Ahhhh. Another day all alone. Everyday feels the same. I wake up, I work as a freelance writer, and I sleep. I wish something more exciting would happen..."}], "Another day")
	#$KnockTimer.start()
	var door_node = get_tree().get_root().find_node("Door", true, false)
	door_node.set_locked(true)
	get_parent().visible = false
	

func _on_KnockTimer_timeout():
	# this code creates and displays a dialogue box
	BackgroundMusic.stop()
	$KnockingSound.play()
	PopUpNode.visible = true
	PopUpNode.show_dialog_box([{avatar = "", text = "*Knock knock*"}], "Knock knock")
	$KnockingSound.stop()
	BackgroundMusic.play()
	$KnockTimer.stop()
	$KnockTimer.queue_free()
	# this code creates and displays a dialogue box	
	

	
func _on_InfoButton_pressed():
	if info_button_open && !visible:
		info_button_open = false
	elif !visible && !info_button_open:
		info_button_open = true
		
func after_note_appears():
	var door_node = get_tree().get_root().find_node("Door", true, false)
	get_parent().visible = false
	
	var toggleQuestButton = get_tree().get_root().find_node("ToggleQuestButton", true, false)
	toggleQuestButton.visible = true





