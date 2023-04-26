extends StaticBody2D

# sets z index of the object so that the object can be moved without messing up the perspective
func _ready():
	var texture_height = $Sprite.texture.get_height()
	z_index = global_position.y - (4 * texture_height / 3)
