extends Node2D

var frog_dad_inventory
var frog_dad_inventory_data
var swaddleQuest = false
var logQuest = false
var questCompleted = false
var QuestContainerScene = preload("res://Scenes/QuestContainer.tscn")

func _ready():
	frog_dad_inventory = get_parent().get_node("Inventory")
	frog_dad_inventory_data = frog_dad_inventory.inventory_data
	swaddleQuest = true
	
func finishQuest(name):
	print(name)
func _process(delta):
	pass

func _on_Quest_visibility_changed():
	if get_parent().visible:
		if swaddleQuest:
			var QuestName = Label.new()
			var SubQuest = QuestContainerScene.instance()
			swaddleQuest(QuestName, SubQuest)
			$VBoxContainer.add_child(QuestName)
			$VBoxContainer.add_child(SubQuest)
			SubQuest.get_node("CompletedButton").connect("pressed", self, "deleteQuest", [SubQuest, QuestName])
		if logQuest:
			var QuestName = Label.new()
			var SubQuest = QuestContainerScene.instance()
			logQuest(QuestName, SubQuest)
			$VBoxContainer.add_child(QuestName)
			$VBoxContainer.add_child(SubQuest)
	else:
		for child in $VBoxContainer.get_children():
			child.queue_free()

func deleteQuest(SubQuest, QuestName):
	SubQuest.queue_free()
	QuestName.queue_free()
	
	
func logQuest(QuestName, SubQuest):
	if logQuest:
		var LOG_REQUIRED = 100
		var totalLog = 0
		for item in frog_dad_inventory_data.inventory:
			if frog_dad_inventory_data.inventory[item][0] == "Log":
				totalLog += frog_dad_inventory_data.inventory[item][1]
		QuestName.text = "Collect Logs for Crib"
		SubQuest.get_node("Label").text = "Collect " + str(LOG_REQUIRED) + " logs: " + str(totalLog) + "/" + str(LOG_REQUIRED) 
		if totalLog >= LOG_REQUIRED:
			SubQuest.get_node("CompletedButton").disabled = false
			

		else: 
			SubQuest.get_node("CompletedButton").disabled = true
			questCompleted = false

func swaddleQuest(QuestName, SubQuest):
	if swaddleQuest:
		var CLOTH_REQUIRED = 5
		var totalCloth = 0
		for item in frog_dad_inventory_data.inventory:
			if frog_dad_inventory_data.inventory[item][0] == "Cloth":
				totalCloth += frog_dad_inventory_data.inventory[item][1]
		QuestName.text = "Make a Swaddle"
		SubQuest.get_node("Label").text = "Collect " + str(CLOTH_REQUIRED) + " pieces of cloth: " + str(totalCloth) + "/" + str(CLOTH_REQUIRED) 
		if totalCloth >= CLOTH_REQUIRED:
			SubQuest.get_node("CompletedButton").disabled = false
			swaddleQuest = false
			logQuest = true

		else: 
			SubQuest.get_node("CompletedButton").disabled = true
			questCompleted = false
