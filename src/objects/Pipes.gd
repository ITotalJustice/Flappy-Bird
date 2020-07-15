extends Node2D


const SPEED := 100.0
const SPAWN_RANGE_Y := 120

	
func _physics_process(delta):
	position.x -= SPEED * delta


func _on_Hitbox_body_entered(body):
	if body.has_method("hit"):
		body.hit()


func _on_Point_body_entered(body):
	if body.has_method("point"):
		body.point()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	

func spawn():
	var yrange := randi() % SPAWN_RANGE_Y
	position.y += yrange


func stop():
	set_physics_process(false)
