extends Node2D
var enums = preload("res://Global/globalEnums.gd")

var mode = enums.MODE.NORMAL
var mouseState = enums.MOUSE_STATE.NONE

var debugNodeNum = 1

func _input(event):
	if (event is InputEventMouseButton) and event.pressed:
		if (mode == enums.MODE.BUILD && mouseState == enums.MOUSE_STATE.OUTSIDE):
				for s in get_tree().get_nodes_in_group("Selectors"):
					s.queue_free()
				mode = enums.MODE.NORMAL
				mouseState = enums.MOUSE_STATE.NONE
				
				
