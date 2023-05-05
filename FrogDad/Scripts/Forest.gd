extends Node2D

func _ready():
	if BackgroundMusic.playing:
		MasterScript.music_position = BackgroundMusic.get_playback_position()
		BackgroundMusic.stop()
	if !$FunkyForestMusic.playing:
		$FunkyForestMusic.play()
	if !$Breeze.playing:
		$Breeze.play()
	for object in $YSort.get_children():
		object.z_index = object.position.y + 20
	if MasterScript.enter_forest:
		$FrogDad.position = $EnterForest.position
		MasterScript.enter_forest = false
	if MasterScript.currentQuestNum >= 2:
		$ItemDrop.hide()
		$ItemDrop3.hide()
		$ItemDrop4.hide()
		$ItemDrop5.hide()
		$ItemDrop6.hide()
		$ItemDrop7.hide()
		$ItemDrop8.hide()
	else:
		$ItemDrop.show()
		$ItemDrop3.show()
		$ItemDrop4.show()
		$ItemDrop5.show()
		$ItemDrop6.show()
		$ItemDrop7.show()
		$ItemDrop8.show()
	if MasterScript.currentQuestNum == 0 or MasterScript.currentQuestNum == 5:
		$FrogDad/AnimatedSprite.animation = "up_holding"
	elif MasterScript.currentQuestNum == 1:
		$FrogDad/AnimatedSprite.animation = "up_swaddle"
	else: 
		$FrogDad/AnimatedSprite.animation = "up"
		

func _process(delta):
	$FrogDad.z_index = $FrogDad.position.y
