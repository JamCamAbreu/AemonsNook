extends Panel

var accum = 0
var TIMER_MAX = 50
var timer = TIMER_MAX
var isPressed = false

func _ready():
	get_node("Button").connect("pressed", self, "_on_Button_pressed")
	
func _on_Button_pressed():
	get_node("Label").text = "Hello!"
	isPressed = true
	timer = TIMER_MAX
	
func _process(delta):
	accum += delta
	
	if (!isPressed ):
		get_node("Label").text = str(accum)
	else:
		timer -= 1
		if (timer <= 0):
			isPressed = false