extends KinematicBody2D


const GRAVITY = 12.0
const FLAP_HIEGHT = -160.0

var velocity := Vector2()


func _physics_process(delta):
	velocity.y += GRAVITY
	if Input.is_action_just_pressed("fly"):
		$Flap.play()
		velocity.y = FLAP_HIEGHT
	move_and_collide(velocity * delta)
	

func hit():
	$Hit.play()
	var parent := get_parent()
	if parent.has_method("game_over"):
		parent.game_over()


func point():
	$Point.play()
	var parent := get_parent()
	if parent.has_method("increase_score"):
		parent.increase_score()
