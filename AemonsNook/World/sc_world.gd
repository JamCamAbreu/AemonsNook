extends Node2D
var enums = preload("res://Global/globalEnums.gd")

var mode = enums.MODE.NORMAL
var mouseState = enums.MOUSE_STATE.NONE

var debugNodeNum = 1

var player

var peepGenerator

var curLevel

var menu

var buildings = []


func SetMode(m):
	mode = m

func Normalize():
	mouseState = enums.MOUSE_STATE.NONE
	remove_child(menu)
	menu = null


func AddBuilding(building):
	buildings.append(building)


func _init():
		# update this process both here and in n2_tiles
	var levelString = "Level04"
	LoadLevel(levelString)
	
	var playerScript = load("res://World/sc_player.gd")
	player = playerScript.new()
	
	var research = curLevel.researchStart
	for r in research:
		player.AddResearch(r)
		
	var buildingsUnlocked = curLevel.buildingsStart
	for b in buildingsUnlocked:
		player.AddBuilding(b)


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
	CheckDeselect(event)
	CheckRightButton(event)
	












# OLD:
func CheckDeselect(mouseEvent):
	if (mouseEvent is InputEventMouseButton) and mouseEvent.pressed:
		if (mode == enums.MODE.BUILD && mouseState == enums.MOUSE_STATE.OUTSIDE):
			for s in get_tree().get_nodes_in_group("Selectors"):
				s.queue_free()
			mode = enums.MODE.NORMAL
			mouseState = enums.MOUSE_STATE.NONE
			remove_child(menu)
			menu = null




func CheckRightButton(mouseEvent):
	if (mouseEvent is InputEventMouseButton and Input.is_action_pressed("ui_menu") and mouseEvent.pressed):
		print("pressed right mouse button")
		
		if (menu == null):
			var radialMenu = load("res://UI/Build/BuildRadialMenu.tscn")
			var rm = radialMenu.instance()
			add_child(rm)
			rm.set_position(get_global_mouse_position())
			rm.CreateBuildingSelection(player.GetBuildingsUnlocked())
			menu = rm
		else:
			remove_child(menu)
			menu = null
			mode = enums.MODE.NORMAL
			mouseState = enums.MOUSE_STATE.NONE



# How to create a build placement:

#		if (menu == null):
#			var menuResource = load("res://UI/Build/BuildPlacement.tscn")
#			var m = menuResource.instance()
#			m.CreatePlacement(enums.BUILDING_TYPE.INN)
#			menu = m
#			add_child(m)
#		else:
#			remove_child(menu)
#			menu = null









