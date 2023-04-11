extends Node2D

func _ready():
	
	var FrogDad = MasterScript.FrogDad
	add_child(FrogDad)
	var CameraNode = $Camera2D.duplicate()
	$Camera2D.queue_free()
	FrogDad.add_child(CameraNode)
	CameraNode.add_child(MasterScript.HUD)
	
	if $FunkyForestMusic.playing == false:
		$FunkyForestMusic.play()
	for object in $YSort.get_children():
		object.z_index = object.position.y + 20
	
	if MasterScript.enter_forest:
		$FrogDad.position = $EnterForest.position
		MasterScript.enter_forest = false
		
func _process(delta):
	$FrogDad.z_index = $FrogDad.position.y
