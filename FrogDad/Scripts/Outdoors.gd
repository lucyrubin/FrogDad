extends Node2D

func _ready():
	for object in $YSort.get_children():
		object.z_index = object.position.y + 20
	if BackgroundMusic.playing == false:
			BackgroundMusic.play()
	if MasterScript.exit_home:
		$FrogDad.position = $ExitHouse.position
		MasterScript.exit_home = false
	if MasterScript.exit_forest:
		$FrogDad.position = $ExitForest.position
		MasterScript.exit_forest = false
	if MasterScript.exitJimothyJohns:
		$FrogDad.position = $ExitJimothyJohns.position
		MasterScript.exitJimothyJohns = false

func _process(_delta):
	$FrogDad.z_index = ($FrogDad.position.y)
