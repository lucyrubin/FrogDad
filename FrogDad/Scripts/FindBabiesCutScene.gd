extends Node2D


func _ready():
	#$Timer.start()
	$SmallPopUpBox.visible = true
	$SmallPopUpBox.show_dialog_box([{avatar = "", text = "Wow, someone trusted me with their babies?"}, {avatar = "", text = "I want to help them, but they look so small and fragile. How should I carry them?"},
							{avatar = "", text = "I should go grab some cloth and make a swaddle."}, {avatar = "", text = "I think I have some around the house..."}], "Wow, someone trusted me with their babies?")
	# this code creates and displays a dialogue box	
	$Timer.queue_free()

func _on_Timer_timeout():
	# this code creates and displays a dialogue box	
	$SmallPopUpBox.visible = true
	$SmallPopUpBox.show_dialog_box([{avatar = "", text = "Wow, someone trusted me with their babies?"}, {avatar = "", text = "I want to help them, but they look so small and fragile. How should I carry them?"},
							{avatar = "", text = "I should go grab some cloth and make a swaddle."}, {avatar = "", text = "I think I have some around the house..."}], "Wow, someone trusted me with their babies?")
	# this code creates and displays a dialogue box	
	$Timer.queue_free()
	
