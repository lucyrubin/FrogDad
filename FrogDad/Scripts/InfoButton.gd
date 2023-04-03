extends TextureButton

var FrogDad
var quest_button_open

# Called when the node enters the scene tree for the first time.
func _ready():
	FrogDad = get_tree().get_root().find_node("FrogDad", true, false)
	$Info/Background.visible = false
	

func _on_InfoButton_pressed():
	if !quest_button_open:
		if $Info/Background.visible == false:
			$Info/Background.visible = true;
			FrogDad.state = "Info"
		else:
			$Info/Background.visible = false;
			FrogDad.state = ""

func _on_ToggleQuestButton_pressed():
	if quest_button_open:
		quest_button_open = false
	else:
		quest_button_open = true
