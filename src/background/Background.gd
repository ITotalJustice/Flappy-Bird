extends Node2D


export var speed := 100.0


func _process(delta):
	$ParallaxBackground.scroll_offset.x -= speed * delta
