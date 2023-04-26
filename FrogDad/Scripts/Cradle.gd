extends StaticBody2D

# sets z index of the cradle so that the cradle can be moved without messing up the perspective
func _ready():
	z_index = global_position.y - 100
