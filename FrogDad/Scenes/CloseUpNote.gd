extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var FrogDadNode
func _ready():
	FrogDadNode = get_parent()
	print(FrogDadNode)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CloseButton_pressed():
	get_parent().get_node("CloseUpNote").visible = false
	var toggleQuestButton = get_parent().get_node("ToggleQuestButton")
	toggleQuestButton.visible = true
	toggleQuestButton.blink() # need to write this method
	FrogDadNode.state = ""
	## change scene to the cut scene of the eggs
