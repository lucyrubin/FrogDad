extends Node2D

func _ready():
	if MasterScript.main:
		$FrogDad.position = $ExitHouse.position
	if MasterScript.forest:
		$FrogDad.position = $ExitForest.position
