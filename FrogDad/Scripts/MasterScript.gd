extends Node


# frog dad variables
var quest_state = "swaddle"
var sprite_image = "carrying babies"


# quest variables
var questDictionary = { 
	# (key, value) = (integer that represents the order that the quests progress, array)
	# resource collection quest array template: ["resource collection", "quest name", number of item required, "item name", "sprite image path"]
	
	0: ["resource collection", "Make a Swaddle", 5, "Cloth", "carrying babies image"],
	1: ["resource collection", "Collect Logs for Crib", 100, "Log", "swaddling babies image"]
	}

var currentQuestNum = -1 # -1 means the intro of getting the note

var currentQuestArray = [questDictionary[0]]
