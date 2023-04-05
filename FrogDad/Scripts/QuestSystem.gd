extends Node2D

var FrogDad_inventory
var FrogDad_inventory_data
var QuestContainerScene = preload("res://Scenes/QuestContainer.tscn")
var DoorScript = preload("res://Scripts/Door.gd")
var KeyIndicatorScene = preload("res://Scenes/KeyIndicator.tscn")
var FrogDad 
var info_button_open

export (NodePath) var inventory_path

func _ready():
	FrogDad = get_tree().get_root().find_node("FrogDad", true, false)
	FrogDad_inventory = FrogDad.find_node("Inventory", true, false)#FrogDad.getInventoryNode()#get_node(inventory_path)
	FrogDad_inventory_data = FrogDad_inventory.inventory_data
	
	if MasterScript.currentQuestNum == -2 :
		begin_intro_quest()
	if MasterScript.currentQuestNum == -1:
		after_note_appears()

func deleteQuest(SubQuest, QuestName):
	# remove quest from MasterScript.currentQuestArray
	#print(MasterScript.currentQuestArray[0])
	FrogDad_inventory.removeItems(MasterScript.currentQuestArray[0][2], MasterScript.currentQuestArray[0][3])
	MasterScript.currentQuestArray.remove(0) # if we have concurrent requests this should be changed to MasterScript.currentQuestNum, not totally sure what else we would need to change though
	if MasterScript.questDictionary.size() > MasterScript.currentQuestNum + 1:
		MasterScript.currentQuestNum+=1
		MasterScript.currentQuestArray.append(MasterScript.questDictionary[MasterScript.currentQuestNum])

		# for testing: show the quest and sprite image as labels
		MasterScript.quest_state = MasterScript.currentQuestArray[0][1]
		MasterScript.sprite_image = MasterScript.currentQuestArray[0][4]
	
	# remove quest from GUI
	SubQuest.queue_free()
	QuestName.queue_free()
	_on_ToggleQuestButton_pressed()
	
func collectResourceQuest(quest, amountRequired, itemType):
	amountRequired = int(amountRequired)
	
	# add a new quest to the GUI
	var QuestName = Label.new()
	var SubQuest = QuestContainerScene.instance()
	$VBoxContainer.add_child(QuestName)
	$VBoxContainer.add_child(SubQuest)
	SubQuest.get_node("CompletedButton").connect("pressed", self, "deleteQuest", [SubQuest, QuestName])
	QuestName.text = quest
	var dynamic_font = DynamicFont.new()
	dynamic_font.size = 25
	dynamic_font.font_data = load("res://Fonts/VCR_OSD_MONO_1.001.ttf")
	QuestName.add_font_override("font", dynamic_font)
	SubQuest.add_font_override("font", dynamic_font)
	QuestName.add_color_override("font_color", Color(0,0,0,1))
	
	# count up the amount of the item in the inventory
	var totalItem = 0
	for item in FrogDad_inventory_data.inventory:
		if FrogDad_inventory_data.inventory[item][0] == itemType:
			totalItem += FrogDad_inventory_data.inventory[item][1]
	
	# update GUI based on amount in inventory
	SubQuest.get_node("Label").text = "Collect " + str(amountRequired) + " " + str(itemType) + "s: \n" + str(totalItem) + "/" + str(amountRequired) 
	
	# check if the requirements have been satisfied
	if totalItem >= amountRequired:
		SubQuest.get_node("CompletedButton").disabled = false
	else: 
		SubQuest.get_node("CompletedButton").disabled = true

func _on_ToggleQuestButton_pressed():
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
				$VBoxContainer.add_child(noQuestLabel)
				
			FrogDad.state = "Quest"
		else:
			# remove all quests from the GUI
			for child in $VBoxContainer.get_children():
				child.queue_free()
			
			FrogDad.state = ""


func begin_intro_quest():
	$KnockTimer.start()
	var door_node = get_tree().get_root().find_node("Door", true, false)
	door_node.set_locked(true)
	get_parent().visible = false
	

func _on_KnockTimer_timeout():
	print("Knock knock") # eventually replace this with a dialogue box showing up
	SceneTransition.change_scene("res://Scenes/NoteCutScene.tscn")
	$KnockTimer.stop()
	$KnockTimer.queue_free()
	
	

func _on_InfoButton_pressed():
	if info_button_open && !visible:
		info_button_open = false
	elif !visible && !info_button_open:
		info_button_open = true
func after_note_appears():
	var door_node = get_tree().get_root().find_node("Door", true, false)
	door_node.set_locked(true)
	get_parent().visible = false
	var main_node = FrogDad.get_parent()
	var note_sprite = FrogDad.get_parent().get_node("Home/YSort/Door/Note")
	# add the note by the door
	note_sprite.visible = true
