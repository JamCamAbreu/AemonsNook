extends AnimatedSprite




func _on_Node2D_mouse_entered():
	var original = get_parent().createdScale
	scale = Vector2(original.x*1.5, original.y*1.5)
	


func _on_Node2D_mouse_exited():
	scale = get_parent().createdScale
