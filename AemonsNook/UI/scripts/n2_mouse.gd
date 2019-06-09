tool
extends Node2D

var lastPos = Vector2()
var curPos = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta):
	
	# new updated position:
	curPos = get_viewport().get_mouse_position()
	set_global_position(curPos)
	
	#var dist = curPos.distance_to(lastPos)
	
	# last step
	lastPos = curPos