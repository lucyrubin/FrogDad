extends Node2D
onready var FrogDad = MasterScript.FrogDad

func _ready():
	## this script adds frog dad to the scene
	FrogDad = MasterScript.FrogDad
	MasterScript.addFrogDad(self)
	## this script adds frog dad to the scene

	for object in $YSort.get_children():
		object.z_index = object.position.y + 20
	
	if MasterScript.exit_home:
		FrogDad.position = $ExitHouse.position
		MasterScript.exit_home = false
	if MasterScript.exit_forest:
		FrogDad.position = $ExitForest.position
		MasterScript.exit_forest = false

func _process(delta):
	FrogDad.z_index = (FrogDad.position.y)
