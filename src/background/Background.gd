extends Node2D


const SPEED := 100.0


func _physics_process(delta):
	$Sky.scroll_offset.x -= SPEED * delta
	$Ground.scroll_offset.x -= SPEED * delta


func _on_Hitbox_body_entered(body):
	if body.has_method("hit"):
		body.hit()


func stop():
	set_physics_process(false)
