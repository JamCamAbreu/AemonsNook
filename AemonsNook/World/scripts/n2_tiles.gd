extends Node2D

var enums = preload("res://Global/globalEnums.gd")
const globalMethods = preload("res://Global/globalMethods.gd")
#const CLICK_SCRIPT = preload("res://Clickable/scripts/clickableArea.gd")

var level

var setupComplete = false

var animationTimerMax = 60
var animationTimer = animationTimerMax

var WIDE = 1
var TALL = 1
var TILE_SIZE_PIXELS = enums.TILE_SIZE_PIXELS
var tiles = [[]]
var waterTiles = []
var pathTiles = []
var edgeTiles = []
var peeps = []



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

func _enter_tree():
	# Get this from a menu or something later:
	var levelString = "res://Levels/Level04.gd"
	var levelScript = load(levelString)
	level = levelScript.new()
	WIDE = level.WIDTH
	TALL = level.HEIGHT


func _ready():
	
	_generateTiles(enums.TILETYPE.GRASS)
	_setTileCardinals()
	BuildWorldFromAscii(level.GetAscii())
	
	setSprites()
	growTrees()
	growStones()
	
	setBuildZoneTiles()
	
	setupComplete = true


func GetTileAtPosition(xPos, yPos):
	if (xPos < WIDE && yPos < TALL):
		return tiles[yPos][xPos]
	else:
		return null



func _process(delta):
	ProcessAnimations()
	pass


func ProcessAnimations():
	animationTimer -= 1
	if (animationTimer <= 0):
		var numSparkles = randi() % 10 + 5
		for i in range(numSparkles):
			createWaterParticle()
			animationTimer = (randi() % animationTimerMax/2) + animationTimerMax/2

func createPeepRandom(amount):
	for a in amount:
		var ranX = randi() % WIDE
		var ranY = randi() % TALL
		createPeep(ranX, ranY)


func createPeep(tileX, tileY):
	var curTile = tiles[tileY][tileX]
	var ps = load("res://Peeps/Peep.tscn")
	var p = ps.instance()
	p.translate(Vector2(tileX * TILE_SIZE_PIXELS, tileY * TILE_SIZE_PIXELS))
	peeps.append(p)
	self.add_child(p)



func createWaterParticle():
	if (waterTiles.size() > 0):
		var i = 0
		var randomIndex = randi() % waterTiles.size()
		var curTile = waterTiles[randomIndex]
		curTile.createWaterSparkle()



# ---- TILES ---- #
func _generateTiles(type):
	var t = load("res://World/sc_tile.tscn")
	for r in range(TALL):
		tiles.append([])
		tiles[r].resize(WIDE)
		for c in range(WIDE):
			var newTile = t.instance()
			newTile.setType(type)
			newTile.translate(Vector2(c * TILE_SIZE_PIXELS, r * TILE_SIZE_PIXELS))
			add_child(newTile)
			tiles[r][c] = newTile

func _setTileCardinals():
	for r in range(TALL):
		for c in range(WIDE):
			var curTile = tiles[r][c]
			if (r > 0):
				curTile.tileAbove = tiles[r - 1][c]
			if (r < (TALL - 1)):
				curTile.tileBelow = tiles[r + 1][c]
			if (c > 0):
				curTile.tileLeft = tiles[r][c - 1]
			if (c < (WIDE - 1)):
				curTile.tileRight = tiles[r][c + 1]






# ---- TILES: GENERATED FROM TXT FILE ---- #

func BuildWorldFromAscii(input):
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
			
		'S':
			tile.setType(enums.TILETYPE.STONE)
			
		'W':
			tile.setType(enums.TILETYPE.WATER)
			waterTiles.append(tile)
		'D':
			tile.setType(enums.TILETYPE.DIRT)
			pathTiles.append(tile)
		'1':
			tile.setType(enums.TILETYPE.DIRT)
			tile.mapEdge = true
			tile.mapEdgeId = 1
			edgeTiles.append(tile)
		'2':
			tile.setType(enums.TILETYPE.DIRT)
			tile.mapEdge = true
			tile.mapEdgeId = 2
			edgeTiles.append(tile)
		'3':
			tile.setType(enums.TILETYPE.DIRT)
			tile.mapEdge = true
			tile.mapEdgeId = 3
			edgeTiles.append(tile)
		'4':
			tile.setType(enums.TILETYPE.DIRT)
			tile.mapEdge = true
			tile.mapEdgeId = 4
			edgeTiles.append(tile)

# ---- CLICKABLES ---- #
func createClickablePos(x, y, type):
	var curTile = tiles[y][x]
	if (curTile.type != enums.TILETYPE.WATER):
		curTile.createClickable(type)

func createClickableRandom(type, amount):
	for a in amount:
		var ranX = randi() % WIDE
		var ranY = randi() % TALL
		createClickablePos(ranX, ranY, type)


func tilesetCheckAbove(original_row, original_column, type, includeBoundaries):
	if (original_row <= 0):
		if (includeBoundaries):
			return true
		else:
			return false
	else:
		var checkTile = tiles[original_row - 1][original_column]
		if (checkTile != null && checkTile.type == type):
			return true
		else:
			return false

func tilesetCheckBelow(original_row, original_column, type, includeBoundaries):
	if (original_row >= TALL - 1):
		if (includeBoundaries):
			return true
		else:
			return false
	else:
		var checkTile = tiles[original_row + 1][original_column]
		if (checkTile != null && checkTile.type == type):
			return true
		else:
			return false

func tilesetCheckLeft(original_row, original_column, type, includeBoundaries):
	if (original_column <= 0):
		if (includeBoundaries):
			return true
		else:
			return false
	else:
		var checkTile = tiles[original_row][original_column - 1]
		if (checkTile != null && checkTile.type == type):
			return true
		else:
			return false

func tilesetCheckRight(original_row, original_column, type, includeBoundaries):
	if (original_column >= WIDE - 1):
		if (includeBoundaries):
			return true
		else:
			return false
	else:
		var checkTile = tiles[original_row][original_column + 1]
		if (checkTile != null && checkTile.type == type):
			return true
		else:
			return false


func getSpriteId(row, column, type, includeBoundaries):
	var sprite_id = 0
	
	if (tilesetCheckAbove(row, column, type, includeBoundaries)):
		sprite_id = sprite_id | 4
	if (tilesetCheckRight(row, column, type, includeBoundaries)):
		sprite_id = sprite_id | 1
	if (tilesetCheckBelow(row, column, type, includeBoundaries)):
		sprite_id = sprite_id | 2
	if (tilesetCheckLeft(row, column, type, includeBoundaries)):
		sprite_id = sprite_id | 8
		
	return sprite_id

func setSprites():
	var rows = TALL
	var cols = WIDE
	for r in range(rows):
		for c in range(cols):
			var curTile = tiles[r][c]
			var id = getSpriteId(r, c, curTile.type, true)
			
			# Dirt types check for building:
			if (curTile.type == enums.TILETYPE.DIRT):
				id = id | getSpriteId(r, c, enums.TILETYPE.BUILDING, true)
			
			# Building types check for dirt:
			if (curTile.type == enums.TILETYPE.BUILDING):
				id = id | getSpriteId(r, c, enums.TILETYPE.DIRT, true)
			
			curTile.setSprite(id)


func growTrees():
	var rows = TALL
	var cols = WIDE
	for r in range(rows):
		for c in range(cols):
			var curTile = tiles[r][c]
			if (curTile.type == enums.TILETYPE.TREE):
				var id = getSpriteId(r, c, curTile.type, true)
				curTile.growTrees(id)


func growStones():
	var rows = TALL
	var cols = WIDE
	for r in range(rows):
		for c in range(cols):
			var curTile = tiles[r][c]
			if (curTile.type == enums.TILETYPE.STONE):
				var id = getSpriteId(r, c, curTile.type, true)
				curTile.growStones(id)
				
func setBuildZoneTiles():
	var rows = TALL
	var cols = WIDE
	for r in range(rows):
		for c in range(cols):
			var curTile = tiles[r][c]
			if (curTile.type == enums.TILETYPE.GRASS):
				var id = getSpriteId(r, c, enums.TILETYPE.DIRT, false) # get paths around this grass
				curTile.isBuildZone = isBuildZoneType(id)


func isBuildZoneType(tileShape):
	var shape = globalMethods.TILE_GET_SHAPE_NAME(tileShape)
	match (shape):
		
		enums.TILE_SHAPE.EMPTY:
			return false
		enums.TILE_SHAPE.HORIZONTAL:
			return true
		enums.TILE_SHAPE.VERTICAL:
			return true
		enums.TILE_SHAPE.UP_LEFT:
			return true
		enums.TILE_SHAPE.UP_RIGHT:
			return true
		enums.TILE_SHAPE.DOWN_RIGHT:
			return true
		enums.TILE_SHAPE.DOWN_LEFT:
			return true
		enums.TILE_SHAPE.RIGHT_T:
			return true
		enums.TILE_SHAPE.DOWN_T:
			return true
		enums.TILE_SHAPE.LEFT_T:
			return true
		enums.TILE_SHAPE.UP_T:
			return true
		enums.TILE_SHAPE.INTERSECTION:
			return true
			






# ---- TILES: MAP SEEDING SYSTEM ---- #

# Typical Usage:
	#_seedRandom(enums.TILETYPE.WATER, 1, "ponds")
	#_growType(enums.TILETYPE.WATER, 5, "ponds", 1)
	#_seedRandom(enums.TILETYPE.WATER, 1, "ponds")
	#_growType(enums.TILETYPE.WATER, 7, "ponds", 1)
	
	#_seedRandom(enums.TILETYPE.TREE, 3, "trees1")
	#_growType(enums.TILETYPE.TREE, 10, "trees1", 1)


# Methods:
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




