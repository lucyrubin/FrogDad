extends StaticBody2D

func _ready():
		if $RadioMusic.playing == false:
			$RadioMusic.play()
