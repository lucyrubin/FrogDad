extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$FrogDad.z_index = ($FrogDad.position.y) # these two lines handle layers to that things that are higher on the screen are 
	$Baby.z_index = -$Baby.position.y # behind things lower on the screen

func toggle_dialogue_box_visibility():
	$FrogDad/DialogueBox.visible = !$FrogDad/DialogueBox.visible

func _input(event):
	if event.is_action_pressed("talk")&&  $Baby/Speech.visible && !$FrogDad/DialogueBox.visible: # when A is pressed, open the dialogue box
		toggle_dialogue_box_visibility()
		$FrogDad.state = "dialogue"
		$FrogDad/AnimatedSprite.stop()
		$Baby/Speech.visible = false
		#$Speech/Timer.start()
	if event.is_action_pressed("close_dialogue") && $FrogDad/DialogueBox.visible: # when Enter is pressed, close the dialogue box
		toggle_dialogue_box_visibility()
		$FrogDad.state = ""
		
