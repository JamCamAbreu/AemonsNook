extends Node2D

const enums = preload("res://Global/globalEnums.gd")

var width
var height

var originX
var originY

var tilesUnder = []

# OTHER VARS HERE:
# building profit
# building capacity



func _ready():
	pass 


func BuildingInit(buildingType, posX, posY):
	SetBuildingSize(buildingType)
	OffsetSprites()
	SetPosition(posX, posY)
	SetTiles()



func OffsetSprites():
	get_node("BottomLayer").set_offset(Vector2((width-1)*16, (height-1)*16))



func SetTiles():
	var tiles = get_node("/root/n2_world/n2_tiles")
	var originTile = tiles.GetTileAtPosition(originX, originY)
	GetAllTileNodes(originTile)
	SetTilesBuildingType()


func SetPosition(posX, posY):
	originX = posX
	originY = posY


func SetTilesBuildingType():
	for t in tilesUnder:
		t.setType(enums.TILETYPE.BUILDING)
	
	# refresh map tile codes:
	get_node("/root/n2_world/n2_tiles").setSprites()



func GetAllTileNodes(originTile):
	if (originTile != null):
		
		var leftEdgeTile = originTile
		for h in range(height):
			
			var tileRight = leftEdgeTile
			for w in range(width):
				tilesUnder.append(tileRight)
				tileRight = tileRight.tileRight

			# Next Row
			leftEdgeTile = leftEdgeTile.tileBelow




func SetBuildingSize(buildingType):
	match buildingType:
		enums.BUILDING_TYPE.ARCHERY:
			get_node("BottomLayer").set_frame(7)
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
			get_node("BottomLayer").set_frame(0)
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
			get_node("BottomLayer").set_frame(7)
			width = 2
			height = 2
		enums.BUILDING_TYPE.CLOTH:
			get_node("BottomLayer").set_frame(5)
			width = 1
			height = 2



