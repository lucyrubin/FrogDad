extends Node

#Mouse cursor variables
var hand = load("res://Art/frog_hand.png")
var pointer = load("res://Art/pointer.png")

# frog dad variables
var quest_state = "swaddle"
var sprite_image = "carrying babies"
var frog_dad_state = ""

var enter_home = false
var exit_forest = false
var exit_home = false
var enter_forest = false
var enter_lettuce_forest = false
var exit_lettuce_forest = false
var findBabies = false
var exitJimothyJohns = false
var picked_up_first_item = false
var after_eggs_to_tadpoles = false
var odie_quest_active = false

var opened_quest_first_time = false
var learn_control_first_time = false
var crib_dialogue_shown = false

# quest variables
var questDictionary = { 
	# (key, value) = (integer that represents the order that the quests progress, array)
	# resource collection quest array template: ["resource collection", "quest name", number of item required, "item name", "sprite image path"]
	
	0: ["resource collection", "Make a Swaddle", 5, "Cloth", "carrying babies image"],
	1: ["resource collection", "Collect Logs for Crib", 7, "Log", "swaddling babies image"],
	2: ["talk", "Get flies from Jimothy John's", "Talk to Jimothy", "Jimothy", "image_here"],
	3: ["resource for character", "Get lettuce for Jimothy", 10, "Lettuce", "image_here"]
	}

var currentQuestNum = -1
# -1 means the intro of getting the note
# 0 is after the note cut scene (baby jar cut scene/swaddle quest)
# 1 is the log quest
# 2 is go get flies from jimothy (talk to jimothy)
# 3 is get lettuce for jimothy

var currentQuestArray = [questDictionary[0]]
