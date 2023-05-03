extends Node2D

const ItemDropClass = preload("res://Scripts/ItemDrop.gd")
const ItemDropScene = preload("res://Scenes/ItemDrop.tscn")

func _ready():
	$FrogDad/AnimatedSprite.animation = "down"
	$FrogDad/AnimatedSprite.frame = 0
	MasterScript.frog_dad_state = ""
	if MasterScript.enter_home:
		$FrogDad.position = $EnterHome.position
		MasterScript.enter_home = false
	if MasterScript.findBabies:
		$FrogDad.position = $EnterHome.position
		MasterScript.findBabies = false
	if MasterScript.enter_cradle_area:
		$FrogDad.position = $EnterCradle.position
		$FrogDad.toggle_dialogue_box_visibility([{avatar = "", text = "Phew! It ain't much, but it's honest work!"},
			{avatar = "", text = "They're almost too big for it! They'll grow out of it soon enough"}]
				, "after cradle dialogue")
		$Home/Cradle.visible = true
		$Home/Jar.visible = true
		$Home/Cradle/CollisionShape2D.disabled = false
		
	if MasterScript.after_eggs_to_tadpoles:
		$FrogDad.position = $EnterCradle.position
		MasterScript.after_eggs_to_tadpoles = false
	if MasterScript.currentQuestNum != 0:
		$ItemDrop5.hide()
		$ItemDrop6.hide()
		$ItemDrop7.hide()
	if MasterScript.currentQuestNum == 0:
		$ItemDrop5.show()
		$ItemDrop6.show()
		$ItemDrop7.show()
	if MasterScript.currentQuestNum < 2:
		$BabyGertrude.visible = false
		$BabyGilbert.visible = false
		$BabyGravyBaby.visible = false
	elif MasterScript.currentQuestNum >= 2 and  MasterScript.currentQuestNum < 6: 
		$Home/Jar.visible = false
		$BabyGertrude.visible = true
		$BabyGilbert.visible = true
		$BabyGravyBaby.visible = true
		$Home/Cradle/CollisionShape2D.disabled = false
		get_tree().get_root().find_node("Cradle", true, false).visible = true
		if MasterScript.enter_cradle_area:
			$Home/Jar.visible = true
			$BabyGilbert.visible = false
			MasterScript.enter_cradle_area = false
	else:
		$BabyGertrude.visible = false
		$BabyGilbert.visible = false
		$BabyGravyBaby.visible = false
		get_tree().get_root().find_node("Cradle", true, false).visible = true
		$Home/Cradle/CollisionShape2D.disabled = false
		$Home/Jar.visible = false
	

func _process(_delta):
	$FrogDad.z_index = ($FrogDad.position.y) # these two lines handle layers to that things that are higher on the screen are 
	$BabyGertrude.z_index = $BabyGertrude.position.y - 10 # behind things lower on the screen
	$BabyGilbert.z_index = $BabyGilbert.position.y + 5
	$BabyGravyBaby.z_index = $BabyGravyBaby.position.y +40

func drop_item(item_drop : ItemDropClass):
	item_drop.setup($FrogDad/AnimatedSprite.global_position.x + 100,$FrogDad/AnimatedSprite.global_position.y + 100,item_drop.item_name, $FrogDad/UserInterface/Inventory )
	add_child(item_drop)	

func add_item_drop(type, x, y):
	var drop = ItemDropScene.instance()
	drop.setup(x,y,type, $FrogDad/UserInterface/Inventory)
	add_child(drop)
