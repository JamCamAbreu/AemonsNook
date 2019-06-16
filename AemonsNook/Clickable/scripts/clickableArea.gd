extends Area2D

signal clicked

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			print("Clicked")
			emit_signal("clicked")
