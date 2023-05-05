extends Node2D

func _ready():
	#makes it look like frog dad is going through the door
	if BackgroundMusic.playing:
		MasterScript.music_position = BackgroundMusic.get_playback_position()
		BackgroundMusic.stop()
		$JimothyJohnsMusic.play()
	$FrogDad.get_node("AnimatedSprite").animation = "up"
	if MasterScript.currentQuestNum == 0:
		$FrogDad/AnimatedSprite.animation = "up_holding"
	elif MasterScript.currentQuestNum == 1:
		$FrogDad/AnimatedSprite.animation = "up_swaddle"
