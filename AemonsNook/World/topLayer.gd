extends AnimatedSprite




func _on_Area2D_mouse_entered():
	if (get_parent().isBuildZone == true):
		#scale = Vector2(1.15, 1.15)
		set_animation("hover")


func _on_Area2D_mouse_exited():
	if (get_parent().isBuildZone == true):
		#scale = Vector2(1, 1)
		set_animation(get_parent().topAnimation)

