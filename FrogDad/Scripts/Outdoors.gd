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
	if MasterScript.exit_lettuce_garden:
		$FrogDad.position = $LettuceForestExit.position
		MasterScript.exit_lettuce_garden = false
	if MasterScript.currentQuestNum == 0 or MasterScript.currentQuestNum == 5:
		$FrogDad/AnimatedSprite.animation = "down_holding"
	elif MasterScript.currentQuestNum == 1:
		$FrogDad/AnimatedSprite.animation = "down_swaddle"
	else: 
		$FrogDad/AnimatedSprite.animation = "down"
	
func _process(_delta):
	$FrogDad.z_index = ($FrogDad.position.y)
