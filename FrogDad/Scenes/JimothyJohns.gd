extends Node2D



func _ready():
	#makes it look like frog dad is going through the door
	$FrogDad.get_node("AnimatedSprite").animation = "up"
	

