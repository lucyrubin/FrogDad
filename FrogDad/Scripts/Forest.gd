extends Node2D
var FrogDad 
func _ready():
	## this script adds frog dad to the scene
	FrogDad = MasterScript.FrogDad
	MasterScript.addFrogDad(self)
	## this script adds frog dad to the scene
	
	if $FunkyForestMusic.playing == false:
		$FunkyForestMusic.play()
	for object in $YSort.get_children():
		object.z_index = object.position.y + 20
	
	if MasterScript.enter_forest:
		FrogDad.position = $EnterForest.position
		MasterScript.enter_forest = false
		
func _process(delta):
	FrogDad.z_index = FrogDad.position.y
