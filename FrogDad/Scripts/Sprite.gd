extends AnimatedSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_parent().global_position.y)
