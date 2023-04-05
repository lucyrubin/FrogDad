extends Node2D

func _ready():
	$FrogDad.position = $ExitHouse
	if get_node("ForestEntrance").get("in_forest"):
		$FrogDad.position = $ExitForest.position
