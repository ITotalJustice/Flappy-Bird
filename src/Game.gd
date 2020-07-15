extends Node2D


enum STATE { idle, play, dead }

var Pipe := preload("res://src/objects/Pipes.tscn")
var can_spawn := false
var score := 0
var state


func _ready():
	state = STATE.idle
	$Player.position.x = 144 / 4
	randomize()
	

func _process(_delta):
	match state:
		STATE.idle:
			if Input.is_action_just_released("fly"):
				state = STATE.play
				$Player.start()
		STATE.play:
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
	var pipe := Pipe.instance()
	add_child(pipe)
	pipe.spawn()
	

func increase_score():
	score += 1


func game_over():
	state = STATE.dead
	get_tree().call_group("game_over", "stop")
	$Background.set_physics_process(false)
	$Death.play()
