extends Node2D
var FrogDad = MasterScript.FrogDad

func _ready():
	add_child(FrogDad)
	var CameraNode = $Camera2D.duplicate()
	$Camera2D.queue_free()
	FrogDad.add_child(CameraNode)
	CameraNode.add_child(MasterScript.HUD)
	
	for object in $YSort.get_children():
		object.z_index = object.position.y + 20
	
	if MasterScript.exit_home:
		FrogDad.position = $ExitHouse.position
		MasterScript.exit_home = false
	if MasterScript.exit_forest:
		FrogDad.position = $ExitForest.position
		MasterScript.exit_forest = false

func _process(delta):
	FrogDad.z_index = (FrogDad.position.y)
