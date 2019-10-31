extends Node2D

const enums = preload("res://Global/globalEnums.gd")

var width
var height

var tilesUnder = []

# OTHER VARS HERE:
# building profit
# building capacity



func _ready():
	pass 

func AddTileUnder(tile):
	tilesUnder.append(tile)


func BuildingInit(buildingType):
	match buildingType:
		enums.BUILDING_TYPE.ARCHERY:
			get_node("BottomLayer").set_frame(4)
			width = 2
			height = 2
		enums.BUILDING_TYPE.BLACKSMITH:
			get_node("BottomLayer").set_frame(5)
			width = 1
			height = 2
		enums.BUILDING_TYPE.TAVERN:
			get_node("BottomLayer").set_frame(1)
			width = 1
			height = 1
		enums.BUILDING_TYPE.BOOTH_PRODUCE:
			get_node("BottomLayer").set_frame(2)
			width = 1
			height = 1
		enums.BUILDING_TYPE.BOOTH_FISH:
			get_node("BottomLayer").set_frame(4)
			width = 1
			height = 1
		enums.BUILDING_TYPE.BOOTH_GEMS:
			get_node("BottomLayer").set_frame(4)
			width = 1
			height = 1
		enums.BUILDING_TYPE.BUTCHER:
			get_node("BottomLayer").set_frame(3)
			width = 1
			height = 1
		enums.BUILDING_TYPE.STABLES:
			get_node("BottomLayer").set_frame(7)
			width = 2
			height = 2
		enums.BUILDING_TYPE.TANNER:
			get_node("BottomLayer").set_frame(6)
			width = 2
			height = 1
		enums.BUILDING_TYPE.SCRIBE:
			get_node("BottomLayer").set_frame(4)
			width = 1
			height = 1
		enums.BUILDING_TYPE.CHAPEL:
			get_node("BottomLayer").set_frame(7)
			width = 2
			height = 2
		enums.BUILDING_TYPE.INN:
			get_node("BottomLayer").set_frame(7)
			width = 2
			height = 2
		enums.BUILDING_TYPE.BOOTH_SEEDS:
			get_node("BottomLayer").set_frame(0)
			width = 1
			height = 1
		enums.BUILDING_TYPE.BATH:
			get_node("BottomLayer").set_frame(1)
			width = 2
			height = 2
		enums.BUILDING_TYPE.CLOTH:
			get_node("BottomLayer").set_frame(2)
			width = 1
			height = 2
