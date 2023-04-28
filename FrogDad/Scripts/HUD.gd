extends CanvasLayer

onready var pause_menu = $PauseMenu

func _process(delta):
	if Input.is_action_just_pressed("move_down") \
	or Input.is_action_just_pressed("move_up") \
	or Input.is_action_just_pressed("move_right") \
	or Input.is_action_just_pressed("move_left"):
		$Controls.visible = false

func new_quest(quest_text):
	$PopUpNotification/HBoxContainer/QuestNameLabel.text = quest_text
	$PopUpNotification.visible = true
	$PopUpNotification/AnimationPlayer.current_animation = "slide_in"
	$PopUpNotification/AnimationPlayer.play()
	$PopUpNotification/PopUpTimer.start()

func _on_PopUpTimer_timeout():
	$PopUpNotification/AnimationPlayer.current_animation = "fade_out"
	$PopUpNotification/AnimationPlayer.play()
	yield($PopUpNotification/AnimationPlayer,'animation_finished')
	$PopUpNotification/AnimationPlayer.stop()

func _on_PauseButton_pressed():
	if MasterScript.frog_dad_state == "":
		pause_menu.show_menu()
