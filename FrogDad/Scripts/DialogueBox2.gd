extends CanvasLayer

const AVATAR_MAP = {
	"gertrude": preload("res://Temporary Clipart/gertrude copy (1).png"),
	"frogDad": preload("res://Temporary Clipart/frog_dad_icon.png")
}

export var interval = 0.1 # interval between when each character shows up

var dialogs = []
var current = 0

onready var content = $Content
onready var avatar = $Content/Avatar

onready var tween = $Content/Tween


func _ready():
	hide_dialog_box()
	show_dialog_box([
		{avatar = "gertrude", text = "Hi, Frog Dad!"},
		{avatar = "frogDad", text = "Hi,Gertrude!"},
		{avatar = "getrude", text = "What are we doing today?"},
		{avatar = "frogDad", text = "Whatever you wish :)"}
	])
	
func _unhandled_input(event):
	# if user pressed "space key" before text animation ends,
	# the animation would be skipped and all text would show
	if event.is_action_pressed("ui_accept"):
		if current + 1 < dialogs.size():
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
	


