extends Node2D

const enums = preload("res://Global/globalEnums.gd")

var width
var height

var valid = false

var squares = []

var SQUARE_SIZE = 32

var whichBuilding


func _ready():
	pass # Replace with function body.

func _process(delta):
	MoveWithMouse()
	CheckValiditySquares()


func CreatePlacement(buildingType):
	match (buildingType):
		enums.BUILDING_TYPE.ARCHERY:
			width = 2
			height = 2
		enums.BUILDING_TYPE.BLACKSMITH:
			width = 1
			height = 2
		enums.BUILDING_TYPE.TAVERN:
			width = 1
			height = 1
		enums.BUILDING_TYPE.BOOTH_PRODUCE:
			width = 1
			height = 1
		enums.BUILDING_TYPE.BOOTH_FISH:
			width = 1
			height = 1
		enums.BUILDING_TYPE.BOOTH_GEMS:
			width = 1
			height = 1
		enums.BUILDING_TYPE.BUTCHER:
			width = 1
			height = 1
		enums.BUILDING_TYPE.STABLES:
			width = 2
			height = 2
		enums.BUILDING_TYPE.TANNER:
			width = 2
			height = 1
		enums.BUILDING_TYPE.SCRIBE:
			width = 1
			height = 1
		enums.BUILDING_TYPE.CHAPEL:
			width = 3
			height = 3
		enums.BUILDING_TYPE.INN:
			width = 3
			height = 2
		enums.BUILDING_TYPE.BOOTH_SEEDS:
			width = 1
			height = 1
		enums.BUILDING_TYPE.BATH:
			width = 2
			height = 2
		enums.BUILDING_TYPE.CLOTH:
			width = 1
			height = 2
	CreateSquares(width, height)


func CreateSquares(setWidth, setHeight):
	var s = load("res://UI/Build/BuildPlacementSquare.tscn")
	for h in range(setHeight):
		squares.append([])
		squares[h].resize(setWidth)
		for w in range(setWidth):
			var newSquare = s.instance()
			newSquare.translate(Vector2(w * SQUARE_SIZE, h * SQUARE_SIZE))
			add_child(newSquare)
			squares[h][w] = newSquare


func MoveWithMouse():
	var mousePos = get_global_mouse_position()
	var snapX = int(mousePos.x) - (int(mousePos.x) % 32)
	var snapY = int(mousePos.y) - (int(mousePos.y) % 32)
	self.set_position(Vector2(snapX, snapY))


func CheckValiditySquares():
	var globalPosX = int(get_global_position().x)
	var globalPosY = int(get_global_position().y)
	var snapX = globalPosX - (globalPosX % 32)
	var snapY = globalPosY - (globalPosY % 32)
	var tilePosX = snapX / 32
	var tilePosY = snapY / 32
	var tiles = get_node("/root/n2_world/n2_tiles")
	
	for h in range(height):
		for w in range(width):
			var tile = tiles.GetTileAtPosition(tilePosX + w, tilePosY + h)
			if (tile != null):
				if (tile.IsBuildable()):
					squares[h][w].SetValid(true)
				else:
					squares[h][w].SetValid(false)


