extends AnimatedSprite

const enums = preload("res://Global/globalEnums.gd")
const paths = preload("res://Global/globalPaths.gd")


func _on_Area2D_mouse_entered():
	var worldNode = get_node(paths.worldNode)
	if (worldNode.mode == enums.MODE.BUILD_ROAD and get_parent().isBuildZone == true):
		set_animation("hover")


func _on_Area2D_mouse_exited():
	if (get_parent().isBuildZone == true):
		set_animation(get_parent().topAnimation)

