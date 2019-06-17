extends Node2D

# get enum from tile:
const TILE_SCRIPT = preload("res://World/scripts/n2_tile.gd")

const WIDE = 40
const TALL = 30
const TILE_SIZE_PIXELS = 16
var tiles = []

enum MAPSIDE { TOP, RIGHT, BOTTOM, LEFT }
const GROW_ALL = "all"

onready var tt = get_node("tileTimer")

func _wait(seconds):
	tt.set_wait_time(seconds)
	tt.set_one_shot(true)
	tt.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	_generateTiles(TILE_SCRIPT.TILETYPE.GRASS)
	
	#_seedCenter(TILE_SCRIPT.TILETYPE.GRASS, 40, "first")
	#_growType(TILE_SCRIPT.TILETYPE.GRASS, 12, "first", 0.5)
	#_wait(2)
	#yield(tt, "timeout")
	
	#_seedSide(TILE_SCRIPT.TILETYPE.GRASS, MAPSIDE.TOP, 20, "side")
	#_seedSide(TILE_SCRIPT.TILETYPE.GRASS, MAPSIDE.TOP, 20, "side")
	#_growType(TILE_SCRIPT.TILETYPE.GRASS, 5, "side", 0.5)
	#_wait(2)
	#yield(tt, "timeout")
	
	_seedSide(TILE_SCRIPT.TILETYPE.WATER, MAPSIDE.RIGHT, 30, "pond1")
	_growType(TILE_SCRIPT.TILETYPE.WATER, 10, "pond1", 0.5)
	
	#_seedRandom(TILE_SCRIPT.TILETYPE.DIRT, 3, "dirt1")
	#_growType(TILE_SCRIPT.TILETYPE.DIRT, 12, "dirt1", 0.5)
	#_wait(2)
	#yield(tt, "timeout")
	createClickableRandom(TILE_SCRIPT.CLICKABLETYPE.TREE, 100)

func createClickableRandom(type, amount):
	for a in amount:
		var ranX = randi() % WIDE
		var ranY = randi() % TALL
		createClickablePos(ranX, ranY, type)
	
	
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
			

func createClickablePos(x, y, type):
	var curTile = tiles[y][x]
	var thing2 = TILE_SCRIPT.TILETYPE.WATER
	if (curTile.type != TILE_SCRIPT.TILETYPE.WATER):
		curTile.createClickable(type)
	else:
		var thing = 2

		var thing3



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


