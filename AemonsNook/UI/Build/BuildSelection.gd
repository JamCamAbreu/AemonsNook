extends Area2D

var globalMethods = preload("res://Global/globalMethods.gd")
var enums = preload("res://Global/globalEnums.gd")

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
			

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_node("/root/n2_world").mode = enums.MODE.NORMAL
			get_node("/root/n2_world").mouseState = enums.MOUSE_STATE.NONE
			for s in get_tree().get_nodes_in_group("Selectors"):
				s.queue_free()

func SetImage(frame):
	get_node("backdrop").set_frame(frame)




func _on_Area2D_mouse_entered():
	get_node("/root/n2_world").mouseState = enums.MOUSE_STATE.INSIDE


func _on_Area2D_mouse_exited():
	get_node("/root/n2_world").mouseState = enums.MOUSE_STATE.OUTSIDE
