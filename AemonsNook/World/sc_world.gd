extends Node2D
var enums = preload("res://Global/globalEnums.gd")

var mode = enums.MODE.NORMAL
var mouseState = enums.MOUSE_STATE.NONE

var debugNodeNum = 1


var peepGenerator

# Eventually, I should get peep generator info while loading up the level.
# I'll need to formalize the level loading process a little bit more
# and balance the coordination between the n2_tiles, sc_world
# a little bit more logically

func _ready():
	
	# update this process both here and in n2_tiles
	var levelString = "res://Levels/Level03.gd"
	var levelScript = load(levelString)
	var level = levelScript.new()
	var tilesid = get_node("n2_tiles")
	var peepGeneratorScript = load("res://Peeps/PeepGenerator.gd")
	peepGenerator = peepGeneratorScript.new()
	self.add_child(peepGenerator)
	peepGenerator.Setup(level, tilesid)





func _input(event):
	Deselect(event)


func Deselect(mouseEvent):
	if (mouseEvent is InputEventMouseButton) and mouseEvent.pressed:
		if (mode == enums.MODE.BUILD && mouseState == enums.MOUSE_STATE.OUTSIDE):
				for s in get_tree().get_nodes_in_group("Selectors"):
					s.queue_free()
				mode = enums.MODE.NORMAL
				mouseState = enums.MOUSE_STATE.NONE


