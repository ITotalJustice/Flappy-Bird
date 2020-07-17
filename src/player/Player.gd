extends KinematicBody2D


enum STATE { idle, play, dead }
const GRAVITY = 12.0
const FLAP_HIEGHT = -160.0

var velocity := Vector2()
var state := 0
var can_fly := false


func _ready():
	state = STATE.idle
	#$AnimationPlayer.play("Idle")
	

func _physics_process(delta):
	match state:
		STATE.idle:
			pass
		STATE.play:
			velocity.x += GRAVITY
			if can_fly:
				can_fly = false
				$Flap.play()
				velocity.x = FLAP_HIEGHT
		STATE.dead:
			velocity.x += GRAVITY
	var _collide := move_and_collide(velocity * delta)


func _process(_delta):
	if Input.is_action_just_pressed("fly"):
		can_fly = true
		

func hit():
	if state == STATE.dead:
		return
	$Hit.play()
	state = STATE.dead
	velocity = Vector2()
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
	$AnimationPlayer.play("Fly")
