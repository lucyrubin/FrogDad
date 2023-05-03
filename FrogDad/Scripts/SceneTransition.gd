
extends CanvasLayer

func change_scene(target: String) -> void:
	$AnimationPlayer.play('dissolve')
	yield($AnimationPlayer,'animation_finished')
	get_tree().change_scene(target)
	$AnimationPlayer.play_backwards('dissolve')
	MasterScript.frog_dad_state = "changing scene"
	yield($AnimationPlayer, "animation_finished")
	MasterScript.frog_dad_state = ""
	
