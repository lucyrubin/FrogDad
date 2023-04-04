extends Area2D

var in_range = false
var FrogDad 

func _ready():
	FrogDad = get_tree().get_root().find_node("FrogDad", true, false)
	print("Frog Dad Node: " , FrogDad)

func _input(event):
#	if event.is_action_pressed("pickup") && in_range && MasterScript.currentQuestNum == -1: 
#		# when the note is picked up, show the close up note and delete the small one
#		var closeUpNoteNode = FrogDad.find_node("CloseUpNote", true, false)
#		closeUpNoteNode.visible = true
#		FrogDad.state = "reading note"
#		in_range = false
#
#		queue_free()
	pass

func _on_Note_area_entered(area):
	print("note area entered")
	in_range = true







func _on_Button_pressed():
	print("button pressed")
	if in_range && MasterScript.currentQuestNum == -1: 
		# when the note is picked up, show the close up note and delete the small one
		var closeUpNoteNode = FrogDad.find_node("CloseUpNote", true, false)
		closeUpNoteNode.visible = true
		FrogDad.state = "reading note"
		in_range = false
		
		queue_free()


func _on_Button_mouse_entered():
	if in_range:
		$Label.add_color_override("font_color", Color(0,100,0,1))


func _on_Button_mouse_exited():
	$Label.add_color_override("font_color", Color(0,0,0,1))


func _on_Note_area_exited(area):
	in_range = false
