extends AnimatedSprite




func _on_Area2D_mouse_entered():
	#scale = Vector2(1.15, 1.15)
	set_animation("hover")


func _on_Area2D_mouse_exited():
	#scale = Vector2(1, 1)
	set_animation(get_parent().topAnimation)
