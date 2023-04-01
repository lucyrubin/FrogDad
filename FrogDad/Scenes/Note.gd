extends Area2D


var in_range

var FrogDadNode 

func _ready():
	FrogDadNode = get_tree().get_root().find_node("FrogDad", true, false)
	print("Frog Dad Node: " , FrogDadNode)

func _input(event):
	if event.is_action_pressed("pickup") && in_range && MasterScript.currentQuestNum == -1: 
		# when the note is picked up, show the close up note and delete the small one
		var closeUpNoteNode = FrogDadNode.find_node("CloseUpNote", true, false)
		closeUpNoteNode.visible = true
		FrogDadNode.state = "reading note"
		in_range = false
		
		queue_free()
		
		

func _on_Note_area_entered(area):
	in_range = true


func _on_Note_area_exited(area):
	in_range = false
