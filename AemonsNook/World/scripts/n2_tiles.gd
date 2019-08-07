extends Node2D

var enums = preload("res://Global/globalEnums.gd")
#const CLICK_SCRIPT = preload("res://Clickable/scripts/clickableArea.gd")

const WIDE = 50
const TALL = 35
const TILE_SIZE_PIXELS = 16
var tiles = []

enum MAPSIDE { TOP, RIGHT, BOTTOM, LEFT }
const GROW_ALL = "all"

onready var tt = get_node("tileTimer")
func _wait(seconds):
	tt.set_wait_time(seconds)
	tt.set_one_shot(true)
	tt.start()

# Global use functions:
func GetMapWidth():
	return (WIDE*TILE_SIZE_PIXELS)
func GetMapHeight():
	return (TALL*TILE_SIZE_PIXELS)


func _ready():
	_generateTiles(enums.TILETYPE.GRASS)
	
	var level = load("res://Levels/Level01.gd")
	BuildWorldFromAscii(level.ascii)
	
	#_seedRandom(enums.TILETYPE.WATER, 1, "ponds")
	#_growType(enums.TILETYPE.WATER, 5, "ponds", 1)
	#_seedRandom(enums.TILETYPE.WATER, 1, "ponds")
	#_growType(enums.TILETYPE.WATER, 7, "ponds", 1)
	
	#_seedRandom(enums.TILETYPE.TREE, 3, "trees1")
	#_growType(enums.TILETYPE.TREE, 10, "trees1", 1)
	

# ---- TILES ---- #
func _generateTiles(type):
	var t = load("res://World/sc_tile.tscn")
	var rows = TALL
	var cols = WIDE
	for r in range(rows):
		tiles.append([])
		tiles[r].resize(WIDE)
		for c in range(cols):
			var newTile = t.instance()
			newTile.setType(type)
			newTile.translate(Vector2(c * TILE_SIZE_PIXELS, r * TILE_SIZE_PIXELS))
			add_child(newTile)
			tiles[r][c] = newTile




# ---- TILES: MAP SEEDING SYSTEM ---- #
func _seedPos(x, y, _seedID, type):
	tiles[y][x].setType(type)
	tiles[y][x].seedID = _seedID

func _seedCenter(type, amount, seedID):
	randomize()
	var centerX = WIDE/2
	var centerY = TALL/2
	var reachX = int(WIDE*0.75)
	var reachY = int(TALL*0.2)
	for a in range(amount):
		var ranX = centerX + ((randi() % reachX) - reachX/2)
		var ranY = centerY + ((randi() % reachY) - reachY/2)
		_seedPos(ranX, ranY, seedID, type)

func _seedRandom(type, amount, seedID):
	for a in amount:
		var ranX = randi() % WIDE
		var ranY = randi() % TALL
		_seedPos(ranX, ranY, seedID, type)

func _seedSide(type, side, amount, seedID):
	match (side):
		MAPSIDE.TOP:
			var maxVariance = int(TALL/10)
			for a in amount:
				var variance = randi() % maxVariance
				var posX = (WIDE/amount)*a
				_seedPos(posX, 0 + variance, seedID, type)
		MAPSIDE.RIGHT:
			var maxVariance = int(WIDE/10)
			for a in amount:
				var variance = randi() % maxVariance
				var posY = (TALL/amount)*a
				_seedPos(WIDE - 1 - variance, posY, seedID, type)
		MAPSIDE.BOTTOM:
			var maxVariance = int(TALL/10)
			for a in amount:
				var variance = randi() % maxVariance
				var posX = (WIDE/amount)*a
				_seedPos(posX, TALL - 1 - variance, seedID, type)
		MAPSIDE.LEFT:
			var maxVariance = int(WIDE/10)
			for a in amount:
				var variance = randi() % maxVariance
				var posY = (TALL/amount)*a
				_seedPos(0 + variance, posY, seedID, type)

func _growType(type, passes, seedID, growSpeed):
	
	# TOP TOP BOTTOM:
	for p in passes:
		for x in WIDE:
			for y in TALL:
				scanAndGrow(type, x, y, 3, 3, seedID)

		# BOTTOM TO TOP:
		for x in range(WIDE - 1, 0, -1):
			for y in range(TALL - 1, 0, -1):
				scanAndGrow(type, x, y, 3, 3, seedID)

		# LEFT TO RIGHT:
		for x in WIDE:
			for y in range(TALL - 1, 0, -1):
				scanAndGrow(type, x, y, 3, 3, seedID)

		# RIGHT TO LEFT:
		for x in range(WIDE - 1, 0, -1):
			for y in TALL:
				scanAndGrow(type, x, y, 3, 3, seedID)

func checkSeedID(tileSeed, _seedID):
	if (_seedID == "all" or tileSeed == _seedID):
		return true
	else:
		return false

func scanAndGrow(type, x, y, rollMax, rollMaxInner, seedID):
	var checkTile
	var curTile = tiles[y][x]
	if (curTile.type == type and checkSeedID(curTile.seedID, seedID)):
		var roll = randi() % rollMax
		
		# CHECK FOR BOUNDARIES:
		if (x > 0) and (roll == 0): # CHECK LEFT BOUNDARY
			checkTile = tiles[y][x - 1]
			if ((randi() % rollMaxInner) == 0):
				checkTile.setType(type)
				checkTile.seedID = seedID
			
		if (x < WIDE - 1) and (roll == 0): # CHECK RIGHT BOUNDARY
			checkTile = tiles[y][x + 1]
			if ((randi() % rollMaxInner) == 0):
				checkTile.setType(type)
				checkTile.seedID = seedID
			
		if (y > 0) and (roll == 0): # CHECK TOP BOUNDARY
			checkTile = tiles[y - 1][x]
			if ((randi() % rollMaxInner) == 0):
				checkTile.setType(type)
				checkTile.seedID = seedID
			
		if (y < TALL - 1) and (roll == 0): # CHECK BOTTOM BOUNDARY
			checkTile = tiles[y + 1][x]
			if ((randi() % rollMaxInner) == 0):
				checkTile.setType(type)
				checkTile.seedID = seedID




# ---- TILES: GENERATED FROM TXT FILE ---- #

func BuildWorldFromAscii(input):
	input = input.replace(" ", "")
	input = input.replace("\n", "")
	var i = 0
	for y in TALL:
		for x in WIDE:
			SetTileType(y, x, input[i])
			i += 1

func SetTileType(row, column, symbol):
	var tile = tiles[row][column]
	match symbol:
		'T':
			tile.setType(enums.TILETYPE.TREE)
		'W':
			tile.setType(enums.TILETYPE.WATER)


# ---- CLICKABLES ---- #
func createClickablePos(x, y, type):
	var curTile = tiles[y][x]
	var thing2 = enums.TILETYPE.WATER
	if (curTile.type != enums.TILETYPE.WATER):
		curTile.createClickable(type)

func createClickableRandom(type, amount):
	for a in amount:
		var ranX = randi() % WIDE
		var ranY = randi() % TALL
		createClickablePos(ranX, ranY, type)






