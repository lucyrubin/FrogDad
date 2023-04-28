extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	z_index = global_position.y - 110
