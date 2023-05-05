extends Panel

var current_fram = 3
var num_frames = 4

func _ready():
	if MasterScript.currentQuestNum >= 4:
		$AnimatedSprite.visible = false

func _on_Plot_gui_input(event):
	if MasterScript.frog_dad_state =="":
		if event is InputEventMouseButton: 
				if event.button_index == BUTTON_LEFT and event.pressed:
					current_fram = (current_fram - 1)
					if current_fram == -1:
						$CPUParticles2D.queue_free()
					elif current_fram == 0:
						if get_node("CPUParticles2D"):
							$CPUParticles2D.restart()
							$CPUParticles2D.emitting = true
							$CPUParticles2D.position.y += 100
						$AnimatedSprite.visible = false
						$ItemDrop.visible = true
					else:
						if get_node("CPUParticles2D"):
							$CPUParticles2D.restart()
							$CPUParticles2D.emitting = true
							$CPUParticles2D.position.y += 100
						$AnimatedSprite.set_frame(current_fram)

func _on_Plot_mouse_entered():
	if MasterScript.frog_dad_state =="" and $AnimatedSprite.visible == true:
		Input.set_custom_mouse_cursor(MasterScript.pointer)

func _on_Plot_mouse_exited():
	if MasterScript.frog_dad_state =="" and $AnimatedSprite.visible == true:
		Input.set_custom_mouse_cursor(MasterScript.hand)
