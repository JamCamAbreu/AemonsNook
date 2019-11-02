tool
extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta):
	
	var posX = get_global_mouse_position().x
	var posY = get_global_mouse_position().y - 32
	
	self.set_position(Vector2(posX, posY))
	
	
	var mousePos = get_global_mouse_position()
	var snapX = (int(mousePos.x) - (int(mousePos.x) % 32))/32
	var snapY = (int(mousePos.y) - (int(mousePos.y) % 32))/32
	get_node("Debug").set_text(str(snapX) + ", " + str(snapY))
	get_node("Debug2").set_text(str(round(mousePos.x)) + ", " + str(round(mousePos.y)))
	