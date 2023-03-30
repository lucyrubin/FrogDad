extends TextureButton

var FrogDadNode

# Called when the node enters the scene tree for the first time.
func _ready():
	FrogDadNode = get_parent()
	$Info/Background.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_InfoButton_pressed():
	if $Info/Background.visible == false:
		$Info/Background.visible = true;
		FrogDadNode.state = "Info"
	else:
		$Info/Background.visible = false;
		FrogDadNode.state = ""
