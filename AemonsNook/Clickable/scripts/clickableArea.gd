extends Area2D

signal clicked

enum CLICK_TYPE { TREE, STONE }

var type


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			print("Clicked")
			emit_signal("clicked")


func _setType(_type):
	type = _type
	match (type):
		CLICK_TYPE.TREE:
			get_node("sprite").set_animation("tree")
		CLICK_TYPE.STONE:
			get_node("sprite").set_animation("stone")