extends Panel
#Code for inventory system is from Arkeve on YouTube: https://www.youtube.com/watch?v=FHYb63ppHmk

# load in textures for the slots
#var default_tex = preload("res://Temporary Clipart/darkLeaf.png")
#var empty_tex = preload("res://Temporary Clipart/lightLeaf.png")
export(Texture) var default_tex
export(Texture) var empty_tex

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null
var ItemClass = preload("res://Scenes/Item.tscn")
var item = null
var slot_index

func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	refresh_style()

func initialize_item(item_name, item_quantity): # sets the slot to be the item given
	if item == null: 
		item = ItemClass.instance()
		item.z_index = 0
		add_child(item)
		item.set_item(item_name, item_quantity)
	else: 
		item.set_item(item_name, item_quantity)
	refresh_style()

	
func pick_from_slot():
	remove_child(item) # remove the item image 
	var inventoryNode = get_tree().get_root().find_node("Inventory", true, false)
	inventoryNode.add_child(item)
	item = null
	refresh_style()
	
func empty_slot():
	remove_child(item) # remove the item image 
	item = null
	refresh_style()

func put_into_slot(new_item):
	item = new_item
	item.get_parent().remove_child(item)
	item.position = Vector2(0,0)
	item.z_index = 0
	add_child(item)
	refresh_style()

func refresh_style():
	# if a slot is empty, set the texture to empty texture
	if item == null:
		set('custom_styles/panel', empty_style)
	else: 
		set('custom_styles/panel', default_style)
