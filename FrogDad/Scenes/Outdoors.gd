extends Node2D

func _ready():
	if MasterScript.exit_home:
		$FrogDad.position = $ExitHouse.position
		MasterScript.exit_home = false
	if MasterScript.exit_forest:
		$FrogDad.position = $ExitForest.position
		MasterScript.exit_forest = false
