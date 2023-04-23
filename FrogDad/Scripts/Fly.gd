extends KinematicBody2D

var velocity

var rng = RandomNumberGenerator.new()

func _ready():
	velocity = Vector2.ZERO
	
func _process(delta):
	velocity.x += rng.randf_range(-100, 100.0)
	velocity.y += rng.randf_range(-100, 100.0)
	move_and_slide(velocity * delta)
