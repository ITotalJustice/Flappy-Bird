extends KinematicBody2D


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
