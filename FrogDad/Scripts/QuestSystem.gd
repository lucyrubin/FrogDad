extends Node2D

var frog_dad_inventory
var frog_dad_inventory_data
var questCompleted = false
var QuestContainerScene = preload("res://Scenes/QuestContainer.tscn")
var FrogDadNode 
var questDictionary = { 
	# (key, value) = (integer that represents the order that the quests progress, array)
	# resource collection quest array template: ["resource collection", "quest name", number of item required, "item name", "sprite image path"]
	0: ["resource collection", "Make a Swaddle", 5, "Cloth", "carrying babies image"],
	1: ["resource collection", "Collect Logs for Crib", 100, "Log", "swaddling babies image"]
	}

var currentQuestNum = 0
var currentQuestArray = [questDictionary[0]]
export (NodePath) var inventory_path

func _ready():
	FrogDadNode = get_parent().get_parent()
	frog_dad_inventory = get_node(inventory_path)
	frog_dad_inventory_data = frog_dad_inventory.inventory_data
	
	

func deleteQuest(SubQuest, QuestName):
	# remove quest from currentQuestArray
	currentQuestArray.remove(0) # if we have concurrent requests this should be changed to currentQuestNum, not totally sure what else we would need to change though
	print(currentQuestArray)
	if questDictionary.size() > currentQuestNum + 1:
		currentQuestNum+=1
		currentQuestArray.append(questDictionary[currentQuestNum])

		# for testing: show the quest and sprite image as labels
		FrogDadNode.quest_state = currentQuestArray[0][1]
		FrogDadNode.sprite_image = currentQuestArray[0][4]
	
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
	
	# count up the amount of the item in the inventory
	var totalItem = 0
	for item in frog_dad_inventory_data.inventory:
		if frog_dad_inventory_data.inventory[item][0] == itemType:
			totalItem += frog_dad_inventory_data.inventory[item][1]
	
	# update GUI based on amount in inventory
	SubQuest.get_node("Label").text = "Collect " + str(amountRequired) + " pieces of cloth: " + str(totalItem) + "/" + str(amountRequired) 
	
	# check if the requirements have been satisfied
	if totalItem >= amountRequired:
		SubQuest.get_node("CompletedButton").disabled = false
	else: 
		SubQuest.get_node("CompletedButton").disabled = true



func _on_ToggleQuestButton_pressed():
	visible = !visible
	if visible:
		# add all current quests to the GUI
		for quest in currentQuestArray:
			if quest[0] == "resource collection":
				collectResourceQuest(quest[1], quest[2], quest[3])
		
		if currentQuestArray.empty():
			var noQuestLabel = Label.new()
			noQuestLabel.text = "No active quests."
			$VBoxContainer.add_child(noQuestLabel)
			
		FrogDadNode.state = "Quest"
	else:
		# remove all quests from the GUI
		for child in $VBoxContainer.get_children():
			child.queue_free()
		
		FrogDadNode.state = ""
