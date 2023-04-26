extends Node2D

const ItemDropClass = preload("res://Scripts/ItemDrop.gd")
const ItemDropScene = preload("res://Scenes/ItemDrop.tscn")

func _ready():
	MasterScript.frog_dad_state = ""
	if MasterScript.enter_home:
		$FrogDad.position = $EnterHome.position
		MasterScript.enter_home = false
	if MasterScript.findBabies:
		$FrogDad.position = $EnterHome.position
		MasterScript.findBabies = false
		
	if MasterScript.currentQuestNum < 2:
		$BabyGertrude.visible = false
		$BabyGilbert.visible = false
		$BabyGravyBaby.visible = false
	else: 
		$BabyGertrude.visible = true
		$BabyGilbert.visible = true
		$BabyGravyBaby.visible = true

func _process(_delta):
	$FrogDad.z_index = ($FrogDad.position.y) # these two lines handle layers to that things that are higher on the screen are 
	$BabyGertrude.z_index = $BabyGertrude.position.y - 10 # behind things lower on the screen
	$BabyGilbert.z_index = $BabyGilbert.position.y - 10
	$BabyGravyBaby.z_index = $BabyGravyBaby.position.y +40

func drop_item(item_drop : ItemDropClass):
	item_drop.setup($FrogDad/AnimatedSprite.global_position.x + 100,$FrogDad/AnimatedSprite.global_position.y + 100,item_drop.item_name, $FrogDad/UserInterface/Inventory )
	add_child(item_drop)	
	

func add_item_drop(type, x, y):
	var drop = ItemDropScene.instance()
	drop.setup(x,y,type, $FrogDad/UserInterface/Inventory)
	add_child(drop)



