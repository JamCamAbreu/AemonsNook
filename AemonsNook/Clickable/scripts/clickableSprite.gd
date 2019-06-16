extends AnimatedSprite




func _on_Node2D_mouse_entered():
	scale = Vector2(1.5, 1.5)
	


func _on_Node2D_mouse_exited():
	scale = Vector2(1.0, 1.0)
