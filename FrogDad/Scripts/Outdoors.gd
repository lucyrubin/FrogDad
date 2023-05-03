extends Node2D

func _ready():
	if !BackgroundMusic.playing:
		BackgroundMusic.play(MasterScript.music_position)
	if MasterScript.exit_home:
		$FrogDad.position = $ExitHouse.position
		MasterScript.exit_home = false
	if MasterScript.exit_forest:
		$FrogDad.position = $ExitForest.position
		MasterScript.exit_forest = false
	if MasterScript.exitJimothyJohns:
		$FrogDad.position = $ExitJimothyJohns.position
		MasterScript.exitJimothyJohns = false
	if MasterScript.exit_lettuce_forest:
		$FrogDad.position = $ExitLettuceForest.position
		MasterScript.exit_lettuce_forest = false

func _process(_delta):
	$FrogDad.z_index = ($FrogDad.position.y)
