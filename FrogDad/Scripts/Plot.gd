extends Panel

var current_fram
var num_frames

func _ready():
	current_fram = 3
	num_frames = 4
	$AnimatedSprite.animation = "default"
	$AnimatedSprite.set_frame(current_fram)

	if MasterScript.currentQuestNum >= 4:
		$AnimatedSprite.visible = false

func _on_Plot_gui_input(event):
	if _left_click(event):
		current_fram = (current_fram - 1) % num_frames
		if current_fram == -1:
			$CPUParticles2D.queue_free()
		elif current_fram == 0:
			$LettuceSound.play()
			$AnimatedSprite.visible = false
			$ItemDrop.visible = true
			_create_particles()
		else:
			$LettuceSound.play()
			$AnimatedSprite.set_frame(current_fram)
			_create_particles()

func _on_Plot_mouse_entered():
	if MasterScript.frog_dad_state =="" and $AnimatedSprite.visible == true:
		Input.set_custom_mouse_cursor(MasterScript.pointer)
		$AnimatedSprite.animation = "hover"
		$AnimatedSprite.set_frame(current_fram)

func _on_Plot_mouse_exited():
	if MasterScript.frog_dad_state =="" and $AnimatedSprite.visible == true:
		Input.set_custom_mouse_cursor(MasterScript.hand)
		$AnimatedSprite.animation = "default"
		$AnimatedSprite.set_frame(current_fram)
		
func _create_particles():
	if get_node("CPUParticles2D"):
		$CPUParticles2D.restart()
		$CPUParticles2D.emitting = true
		$CPUParticles2D.position.y += 100

func _left_click(event):
	return MasterScript.frog_dad_state == "" \
	and event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed
