extends Node2D


enum STATE { idle, play, dead }
const PIPE := preload("res://src/objects/Pipes.tscn")

var can_spawn := false
var score := 0
var state := 0


func _ready():
	state = STATE.idle
	randomize()
	

func _process(_delta):
	match state:
		STATE.idle:
			if Input.is_action_just_pressed("fly"):
				state = STATE.play
				$Player.start()
				$Menu/Intro.hide()
				$Menu/HUD.show()
		STATE.play:
			if Input.is_action_just_pressed("pause"):
				pause(!get_tree().paused)
			if can_spawn:
				spawn_pipe()
		STATE.dead:
			if Input.is_action_just_released("restart"):
				if get_tree().reload_current_scene() != OK:
					print("failed to reload scene")
	

func _on_PipeSpawner_timeout():
	can_spawn = true


func spawn_pipe():
	can_spawn = false
	$SpawnDelay.start()
	var pipe := PIPE.instance()
	add_child(pipe)
	pipe.spawn()
	

func increase_score():
	score += 1
	$Menu/HUD/Score.text = String(score)


func game_over():
	state = STATE.dead
	get_tree().call_group("game_over", "stop")
	$Menu/HUD.hide()
	$Menu/Death/Score.text = String(score)
	$Menu/Death.show()
	$Background.set_physics_process(false)
	$Death.play()


func pause(flag: bool):
	get_tree().paused = flag
	if flag:
		$Menu/Pause.show()
	else:
		$Menu/Pause.hide()


func _on_PauseButton_toggled(button_pressed):
	pause(button_pressed)
