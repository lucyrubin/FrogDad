extends CanvasLayer

const AVATAR_MAP = {
	"gertrude":preload("res://Temporary Clipart/gertrude copy.png")
}

export var interval = 0.1 # interval between when each character shows up

var dialogs = [] # all conversations that need to be displayed
var current = 0 # the number of the line currently being displayed

onready var content = $Content
onready var avatar = $Content/Avatar
onready var next_indicator = $Content/NextIndicator
onready var tween = $Content/Tween

func _ready():
	hide_dialog_box()
	show_dialog_box([
		{avatar="gertrude", text="Hello!"},
		{avatar="frogdad", text="Hi Gertrude!"}
	])
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		# if user pressed "space key" before text animation ends,
		# the animation would be skipped and all text would show
		if tween.is_active():
			tween.remove_all()
			content.percent_visible = 1
			next_indicator.show()
		elif current + 1 < dialogs.size():
			_show_dialog(current + 1)
		else:
			hide_dialog_box()
		get_tree().set_input_as_handled()

func hide_dialog_box():
	content.hide()
	
func show_dialog_box(_dialogs):
	dialogs = _dialogs
	content.show()
	_show_dialog(0)
	
func _show_dialog(index):
	current = index
	var dialog = dialogs[current]
	content.text = dialog.text
	avatar.texture = AVATAR_MAP[dialog.avatar]
	
	next_indicator.hide()
	tween.interpolate_property(
		content, "percent_visible", 0, 1, # changing the percent visible property of content from 0 to 1
		interval * content.text.length(), # total time of the animation
		Tween.TRANS_LINEAR
	)
	tween.start()


func _on_Tween_tween_all_completed():
	next_indicator.show()


func _on_Content_visibility_changed():
	get_tree().paused = content.visible
