extends Node2D

func _ready():
	for object in $YSort.get_children():
		object.z_index = object.position.y + 140
	for object in $LettuceYSort.get_children():
		var sprite = object.get_node("AnimatedSprite")
		var item_drop = object.get_node("ItemDrop")
		sprite.z_index = object.rect_position.y + 130
		item_drop.z_index = item_drop.position.y + 20
	$FrogDad.position = $Position2D.position
