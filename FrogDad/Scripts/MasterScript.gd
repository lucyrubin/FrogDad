extends Node

# frog dad variables
var quest_state = "swaddle"
var sprite_image = "carrying babies"


var enter_home = false
var exit_forest = false
var exit_home = false
var enter_forest = false
var findBabies = false

var picked_up_first_item = false

var opened_quest_first_time = false

# quest variables
var questDictionary = { 
	# (key, value) = (integer that represents the order that the quests progress, array)
	# resource collection quest array template: ["resource collection", "quest name", number of item required, "item name", "sprite image path"]
	
	0: ["resource collection", "Make a Swaddle", 5, "Cloth", "carrying babies image"],
	1: ["resource collection", "Collect Logs for Crib", 7, "Log", "swaddling babies image"]
	}

var currentQuestNum = -1
# -1 means the intro of getting the note
# 0 is after the note cut scene

var currentQuestArray = [questDictionary[0]]
