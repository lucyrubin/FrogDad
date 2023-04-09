extends CanvasLayer

const AVATAR_MAP = {
	"gertrude": preload("res://Temporary Clipart/gertrude copy (1).png"),
	"frogDad": preload("res://Temporary Clipart/frog_dad_icon.png")
}

export var interval = 0.05 # interval betext_animation when each character shows up

var dialogs = []
var current = 0

onready var content = $Content
onready var next_indicator = $Content/NextIndicator
onready var text_animation = $Content/TextAnimation
onready var avatar 


func _input(event):

	# if user pressed "space key" before text animation ends,
#	# the animation would be skipped and all text would show
	if event.is_action_pressed("open"):
		if text_animation.is_active():
			text_animation.remove_all()
			content.percent_visible = 1
			_on_TextAnimation_tween_all_completed()
		elif current + 1 < dialogs.size():
			_show_dialog(current + 1)
		else:
			hide_dialog_box()


func hide_dialog_box():

	content.hide()
	
func show_dialog_box(_dialogs):
	print("show dialogue box")
	content = $Content
	next_indicator = $Content/NextIndicator
	text_animation = $Content/TextAnimation
	if $Content.get_node("Avatar"):
		avatar = $Content/Avatar
	dialogs = _dialogs

	content.show()
	_show_dialog(0)
	
func _show_dialog(index):
	
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
	get_tree().paused = content.visible


func _on_TextAnimation_tween_all_completed():

	next_indicator.show()
	
