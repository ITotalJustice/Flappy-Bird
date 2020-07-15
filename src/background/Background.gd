extends Node2D


const SPEED := 100.0


func _physics_process(delta):
	$ParallaxBackground.scroll_offset.x -= SPEED * delta
