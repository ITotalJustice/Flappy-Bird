extends KinematicBody2D


enum STATE { idle, play, dead }
const GRAVITY = 12.0
const FLAP_HIEGHT = -160.0

var velocity := Vector2()
var state


func _ready():
	state = STATE.idle
	

func _physics_process(delta):
	var _collide := move_and_collide(velocity * delta)
	

func _process(_delta):
	match state:
		STATE.idle:
			pass
		STATE.play:
			velocity.y += GRAVITY
			if Input.is_action_just_pressed("fly"):
				$Flap.play()
				velocity.y = FLAP_HIEGHT
		STATE.dead:
			velocity.y += GRAVITY

	
func hit():
	if state == STATE.dead:
		return
	$Hit.play()
	velocity = Vector2()
	state = STATE.dead
	$AnimationPlayer.stop()
	var parent := get_parent()
	if parent.has_method("game_over"):
		parent.game_over()


func point():
	if state == STATE.dead:
		return
	$Point.play()
	var parent := get_parent()
	if parent.has_method("increase_score"):
		parent.increase_score()


func start():
	state = STATE.play
