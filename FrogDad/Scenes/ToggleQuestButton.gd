extends TextureButton
onready var FrogDad = get_tree().get_root().find_node("FrogDad", true, false)
func blink():
	$BouncingArrow.visible = true
	$BouncingArrow.get_node("TextureRect/AnimationPlayer").play()

func _input(event):
	if event.is_action_pressed("escape"):  
		if $Quest.visible: # close info
			$Quest.visible = false
			FrogDad.state = ""
			FrogDad.get_node("AnimatedSprite").play()
			
			# remove all quests from the GUI
			for child in $Quest/VBoxContainer.get_children():
				child.queue_free()
