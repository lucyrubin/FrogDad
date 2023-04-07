extends Node2D

func _ready():
	if MasterScript.enter_forest:
		$FrogDad.position = $EnterForest.position
		MasterScript.enter_forest = false
