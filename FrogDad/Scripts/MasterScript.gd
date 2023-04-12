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

var FrogDad
var HUD
var FrogDadScene = preload("res://Scenes/FrogDad.tscn")
var HUDScene = preload("res://Scenes/HUD.tscn")

func _ready():
	print("ready")
	FrogDad = FrogDadScene.instance()
	add_child(FrogDad)
	FrogDad = get_node("FrogDad")
	HUD = HUDScene.instance()
#	add_child(HUD)
#	HUD = get_node("HUD")

func addFrogDad(scene):
	scene.add_child(FrogDad)
	var CameraNode = scene.find_node("Camera2D", true, false)#.duplicate()
	#scene.find_node("Camera2D", true, false).queue_free()
	FrogDad.add_child(CameraNode)
	CameraNode.add_child(HUD)
	var remoteT = FrogDad.get_node("RemoteTransform2D")
	FrogDad.get_node("RemoteTransform2D").remote_path = CameraNode.get_path()

# quest variables
var questDictionary = { 
	# (key, value) = (integer that represents the order that the quests progress, array)
	# resource collection quest array template: ["resource collection", "quest name", number of item required, "item name", "sprite image path"]
	
	0: ["resource collection", "Make a Swaddle", 5, "Cloth", "carrying babies image"],
	1: ["resource collection", "Collect Logs for Crib", 100, "Log", "swaddling babies image"]
	}

var currentQuestNum = -2 # -2 means the intro of getting the note
# -1 is after the note cut scene

var currentQuestArray = [questDictionary[0]]
