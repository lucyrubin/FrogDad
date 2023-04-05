extends Node2D

var VELOCITY = 4.5
var ACCELERATION = 0.04
var start = false

func _ready():
	$Timer.start()
	$WaitToStartAnimationTimer.start()

func _process(delta):
	if VELOCITY > 0 and start:
		$Note.position.y += VELOCITY
		VELOCITY -= ACCELERATION



func _on_Timer_timeout():
	SceneTransition.change_scene("res://Scenes/Main.tscn")
	MasterScript.currentQuestNum +=1
	$Timer.queue_free()


func _on_WaitToStartAnimationTimer_timeout():
	start = true
	$WaitToStartAnimationTimer.queue_free()
