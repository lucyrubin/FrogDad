extends Area2D

export (PackedScene) var target_scene 
const FrogDadClass = preload("res://Scripts/FrogDad.gd")
const PickUpZoneClass = preload("res://Scripts/PickupZone.gd")
onready var FrogDad = get_tree().get_root().find_node("FrogDad", true, false)

var door_opened = false
var current_fram = 0
var num_frames = 2
var locked = false
var mouse_in = false

func _ready():
	$AnimatedSprite.animation = "default"
	set_frame(0)
	
func set_locked(boolean):
	set_frame(0)
	locked = boolean

func go_outside():
	if !locked:
		$DoorSound.play()
		MasterScript.exit_home = true
		SceneTransition.change_scene("res://Scenes/Outdoors.tscn")

# show open door frame		
func _on_Door_area_entered(area):
	if area is PickUpZoneClass:
		# dont let the door be opened during the intro
		if MasterScript.currentQuestNum == -1:
			set_frame(0)
		else:
			$AnimatedSprite.animation = "hover"
			door_opened = true
			set_frame(1)

# show closed door frame
func _on_Door_area_exited(area):
	if area is PickUpZoneClass:
		if !locked:
			$AnimatedSprite.animation = "default"
			door_opened = false
			set_frame(0)

func _on_EnteranceArea_body_entered(body):
	if body is FrogDadClass and !locked:
		go_outside()

func set_frame(frame_num):
	current_fram = frame_num
	$AnimatedSprite.set_frame(current_fram)
