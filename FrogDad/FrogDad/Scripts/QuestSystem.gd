extends Node2D


var swaddleQuest = false

func _ready():
	swaddleQuest = true
	

func _process(delta):
	if swaddleQuest:
		$SingleQuest/Label.text = "ignore this, i'm just using \n this for testing :) - lucy"
