extends Node2D


var Pipe := preload("res://src/objects/Pipes.tscn")
var can_spawn := false
var score := 0


func _ready():
	pass
	

func _process(delta):
	if can_spawn:
		spawn_pipe()
	

func _on_PipeSpawner_timeout():
	can_spawn = true


func spawn_pipe():
	var pipe := Pipe.instance()
	add_child(pipe)
	pipe.spawn()
	

func increase_score():
	score += 1
	$Point.play()


func game_over():
	$Death.play()
