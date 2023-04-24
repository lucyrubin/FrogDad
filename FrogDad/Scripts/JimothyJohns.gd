extends Node2D



func _ready():
	#makes it look like frog dad is going through the door
	if BackgroundMusic.playing:
			BackgroundMusic.stop()
			$JimothyJohnsMusic.play()
	$FrogDad.get_node("AnimatedSprite").animation = "up"
	

