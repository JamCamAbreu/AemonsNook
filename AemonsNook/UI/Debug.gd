extends CanvasLayer

var enums = preload("res://Global/globalEnums.gd")

var numTasks = 0

var ready = false
onready var FPS_val = get_node("MarginContainer/rows/row1/FPS/Rect/value")
onready var NODES_val = get_node("MarginContainer/rows/row1/NumNodes/Rect/value")
onready var TILES_val = get_node("MarginContainer/rows/row1/NumTiles/Rect/value")
onready var CLICKS_val = get_node("MarginContainer/rows/row1/NumClickables/Rect/value")
onready var EFFECTS_val = get_node("MarginContainer/rows/row1/NumEffects/Rect/value")
onready var PEEPS_val = get_node("MarginContainer/rows/row1/NumPeeps/Rect/value")
onready var BUILD_MODE_val = get_node("MarginContainer/rows/row2/mode/Rect/value")
onready var MOUSE_STATE_val = get_node("MarginContainer/rows/row2/mouseState/Rect/value")
onready var NUM_TASKS_val = get_node("MarginContainer/rows/row2/numTasks/Rect/value")


func _ready():
	ready = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (ready):
		FPS_val.text = str(Engine.get_frames_per_second())
		NODES_val.text = str(get_tree().get_nodes_in_group("Objects").size())
		TILES_val.text = str(get_tree().get_nodes_in_group("Tiles").size())
		CLICKS_val.text = str(get_tree().get_nodes_in_group("Clickables").size())
		EFFECTS_val.text = str(get_tree().get_nodes_in_group("Effects").size())
		PEEPS_val.text = str(get_tree().get_nodes_in_group("Peeps").size())
		BUILD_MODE_val.text = ModeToString(get_node("/root/n2_world").mode)
		MOUSE_STATE_val.text = MSToString(get_node("/root/n2_world").mouseState)
		NUM_TASKS_val.text = str(numTasks)



func ModeToString(mode):
	match mode:
		enums.MODE.NORMAL:
			return "NORMAL"
		enums.MODE.BUILD:
			return "BUILD"

func MSToString(ms):
	match ms:
		enums.MOUSE_STATE.NONE:
			return "NONE"
		enums.MOUSE_STATE.INSIDE:
			return "INSIDE"
		enums.MOUSE_STATE.OUTSIDE:
			return "OUTSIDE"
