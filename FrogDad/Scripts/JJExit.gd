extends Area2D

const PickupZoneClass = preload("res://Scripts/PickupZone.gd")
var target_scene = "res://Scenes/Outdoors.tscn"

func _on_Exit_area_entered(area):

	if area is PickupZoneClass:
		$DoorSound.play()
		MasterScript.exitJimothyJohns = true
		SceneTransition.change_scene(target_scene)
