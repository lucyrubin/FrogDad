extends Node2D

func _ready():
	if MasterScript.outdoors:
		$FrogDad.position = $EnterForest.position
