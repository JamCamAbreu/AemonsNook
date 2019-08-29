extends Area2D

var globalMethods = preload("res://Global/globalMethods.gd")

var target  # Vector2, set by parent
var ready = false
var arrived = false

func _process(delta):
	if (ready and !arrived):
		var newX = globalMethods.Ease(get_position().x, target.x, 0.2)
		var newY = globalMethods.Ease(get_position().y, target.y, 0.2)
		set_position(Vector2(newX, newY))

		if (get_position().distance_to(target) <= 1):
			set_position(target)
			arrived = true