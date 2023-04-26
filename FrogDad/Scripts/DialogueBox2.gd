extends CanvasLayer

const AVATAR_MAP = {
	"gertrude": preload("res://Temporary Clipart/gertrude copy (1).png"),
	"frogDad": preload("res://Temporary Clipart/frog_dad_icon.png"),
	"jimothy": preload("res://CharacterHeads/JimothyHead.png"),
	"gilbert": preload("res://CharacterHeads/gilberthead.png"),
	"gravy": preload("res://CharacterHeads/gravyhead.png")
}

export var interval = 0.05 # interval betext_animation when each character shows up

var dialogs = []
var current = 0

onready var content = $Content
onready var next_indicator = $Content/NextIndicator
onready var text_animation = $Content/TextAnimation
onready var avatar 
onready var FrogDad = get_tree().get_root().find_node("FrogDad", true, false)

var completed
var dialogue_name

	
func _input(event):

	# if user pressed "space key" before text animation ends,
#	# the animation would be skipped and all text would show

	if event.is_action_pressed("open") and content.visible:

		if FrogDad:
			MasterScript.frog_dad_state= "talking" # player can't move during dialogue
		if text_animation.is_active():

			text_animation.remove_all()
			content.percent_visible = 1
			_on_TextAnimation_tween_all_completed()
		elif current + 1 < dialogs.size():

			_show_dialog(current + 1)
		else:
			hide_dialog_box()


func hide_dialog_box():
	if FrogDad:
		MasterScript.frog_dad_state = "" # player can move again
	content.hide()
	completed = true
	$ColorRect.hide()
	##
	##
	##
	# If you want to do something after a dialogue, do it here
	# this code handles what should happen after a dialogue finished
	if MasterScript.currentQuestNum == -1 and dialogue_name == "Another day": 
		# after ahhh another day
		get_tree().get_root().find_node("KnockTimer", true, false).start()
	elif dialogue_name == "Knock knock":
		# after knock knock
		SceneTransition.change_scene("res://Scenes/NoteCutScene.tscn")
	elif dialogue_name == "Wow, someone trusted me with their babies?":
		# after babies cut scene
		MasterScript.findBabies = true
		SceneTransition.change_scene("res://Scenes/Main.tscn")
		
	elif dialogue_name == "Finished cloth quest": 
		## after finished cloth quest dialouge
		show_new_quest_notifcation_box()
	elif dialogue_name == "Finished log quest":
		show_new_talk_quest_notification_box()
	elif dialogue_name == "jimothy first talk":
		MasterScript.currentQuestNum+=1
		MasterScript.currentQuestArray = [MasterScript.questDictionary[3]]
		show_new_quest_notifcation_box()
	# If you want to do something after a dialogue, do it here
	##
	##
	##
func show_new_talk_quest_notification_box():
	var HUDNode = FrogDad.find_node("HUD", true, false)
	HUDNode.new_quest(MasterScript.currentQuestArray[0][2])
func show_new_quest_notifcation_box():
	var HUDNode = FrogDad.find_node("HUD", true, false)
	HUDNode.new_quest(MasterScript.currentQuestArray[0][1])
	
	
func show_dialog_box(_dialogs, dialogueName):
	$ColorRect.show()
	dialogue_name = dialogueName
	if FrogDad:
		MasterScript.frog_dad_state = "talking" # player can't move during dialogue
	completed = false
	content = $Content
	next_indicator = $Content/NextIndicator
	text_animation = $Content/TextAnimation
	if $Content.get_node("Avatar"):
		avatar = $Content/Avatar
	dialogs = _dialogs

	content.show()
	_show_dialog(0)
	
func _show_dialog(index):
	if FrogDad:
		MasterScript.frog_dad_state= "talking" # player can't move during dialogue
	
	current = index

	var dialog = dialogs[current]
	content.text = dialog.text
	if dialog.avatar != "":
		avatar.texture = AVATAR_MAP[dialog.avatar]
	
	next_indicator.hide()
	text_animation.interpolate_property(
		content, "percent_visible", 0, 1, 
		interval * content.text.length(),
		text_animation.TRANS_LINEAR
	)
	
	text_animation.start()
	
	

func _on_Content_visibility_changed():
	pass
	#get_tree().paused = content.visible


func _on_TextAnimation_tween_all_completed():
	next_indicator.show()
	
