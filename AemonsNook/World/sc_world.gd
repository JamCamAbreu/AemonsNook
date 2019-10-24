extends Node2D
var enums = preload("res://Global/globalEnums.gd")

var mode = enums.MODE.NORMAL
var mouseState = enums.MOUSE_STATE.NONE

var debugNodeNum = 1

var player

var peepGenerator

var curLevel


func _init():
		# update this process both here and in n2_tiles
	var levelString = "Level04"
	LoadLevel(levelString)
	
	var playerScript = load("res://World/sc_player.gd")
	player = playerScript.new()
	
	var research = curLevel.researchStart
	for r in research:
		player.AddResearch(r)


# Eventually, I should get peep generator info while loading up the level.
# I'll need to formalize the level loading process a little bit more
# and balance the coordination between the n2_tiles, sc_world
# a little bit more logically

func LoadLevel(levelString):
	var curLevelScript = load("res://Levels/" + levelString + ".gd")
	curLevel = curLevelScript.new()

func _ready():
	var tilesid = get_node("n2_tiles")
	var peepGeneratorScript = load("res://Peeps/PeepGenerator.gd")
	peepGenerator = peepGeneratorScript.new()
	self.add_child(peepGenerator)
	peepGenerator.Setup(curLevel, tilesid)

	var tilesNode = get_node("n2_tiles")
	if (tilesNode != null && tilesNode.setupComplete == true):
		var centerX = tilesNode.WIDE/2
		var centerY = tilesNode.TALL/2
		var centerTile = tilesNode.tiles[centerY][centerX]
		get_node("playerView").position = centerTile.getPos()



func _input(event):
	Deselect(event)


func Deselect(mouseEvent):
	if (mouseEvent is InputEventMouseButton) and mouseEvent.pressed:
		if (mode == enums.MODE.BUILD && mouseState == enums.MOUSE_STATE.OUTSIDE):
				for s in get_tree().get_nodes_in_group("Selectors"):
					s.queue_free()
				mode = enums.MODE.NORMAL
				mouseState = enums.MOUSE_STATE.NONE


