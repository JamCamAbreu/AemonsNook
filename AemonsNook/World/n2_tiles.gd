extends Node2D

# get enum from tile:
const TILE_SCRIPT = preload("res://World/scripts/n2_tile.gd")

var WIDE = 80
var TALL = 60
var tiles = []

enum MAPSIDE { TOP, RIGHT, BOTTOM, LEFT }

onready var t = get_node("tileTimer")

func _wait(seconds):
	t.set_wait_time(seconds)
	t.set_one_shot(true)
	t.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	_generateTiles(TILE_SCRIPT.TILETYPE.TREE)
	_wait(1)
	yield(t, "timeout")
	_seedCenter(TILE_SCRIPT.TILETYPE.GRASS, 20)
	_wait(1)
	yield(t, "timeout")
	_growType(TILE_SCRIPT.TILETYPE.GRASS, 7)
	_wait(1)
	yield(t, "timeout")
	_seedSide(TILE_SCRIPT.TILETYPE.GRASS, MAPSIDE.TOP, 20)
	_seedSide(TILE_SCRIPT.TILETYPE.GRASS, MAPSIDE.TOP, 20)
	_wait(1)
	yield(t, "timeout")
	_growType(TILE_SCRIPT.TILETYPE.GRASS, 3)


func _generateTiles(type):
	var t = load("res://World/n2_tile.tscn")
	var rows = TALL
	var cols = WIDE
	for r in range(rows):
		tiles.append([])
		tiles[r].resize(WIDE)
		for c in range(cols):
			var newTile = t.instance()
			newTile.setType(type)
			newTile.translate(Vector2(c * 16, r * 16))
			add_child(newTile)
			tiles[r][c] = newTile

func _seedCenter(type, amount):
	randomize()
	var centerX = WIDE/2
	var centerY = TALL/2
	var reachX = int(WIDE*0.85)
	var reachY = int(TALL*0.5)
	for a in range(amount):
		var ranX = centerX + ((randi() % reachX) - reachX/2)
		var ranY = centerY + ((randi() % reachY) - reachY/2)
		tiles[ranY][ranX].setType(type)

func _seedSide(type, side, amount):
	match (side):
		MAPSIDE.TOP:
			var maxVariance = int(TALL/10)
			for a in amount:
				var variance = randi() % maxVariance
				var posX = (WIDE/amount)*a
				tiles[0 + variance][posX].setType(type)
		MAPSIDE.RIGHT:
			var thing = 2
		MAPSIDE.BOTTOM:
			var thing = 2
		MAPSIDE.LEFT:
			var thing = 2

func _growType(type, passes):
	
	# TOP TOP BOTTOM:
	for p in passes:
		for x in WIDE:
			for y in TALL:
				scanAndGrow(type, x, y, 3, 3)
				
		# BOTTOM TO TOP:
		for x in range(WIDE - 1, 0, -1):
			for y in range(TALL - 1, 0, -1):
				scanAndGrow(type, x, y, 3, 3)
				
		# LEFT TO RIGHT:
		for x in WIDE:
			for y in range(TALL - 1, 0, -1):
				scanAndGrow(type, x, y, 3, 3)
			
		# RIGHT TO LEFT:
		for x in range(WIDE - 1, 0, -1):
			for y in TALL:
				scanAndGrow(type, x, y, 3, 3)
		
		_wait(0.2)
		yield(t, "timeout")


func scanAndGrow(type, x, y, rollMax, rollMaxInner):
	var checkTile
	var curTile = tiles[y][x]
	if (curTile.type == type):
		var roll = randi() % rollMax
		
		# CHECK FOR BOUNDARIES:
		if (x > 0) and (roll == 0): # CHECK LEFT BOUNDARY
			checkTile = tiles[y][x - 1]
			if ((randi() % rollMaxInner) == 0):
				checkTile.setType(type)
			
		if (x < WIDE - 1) and (roll == 0): # CHECK RIGHT BOUNDARY
			checkTile = tiles[y][x + 1]
			if ((randi() % rollMaxInner) == 0):
				checkTile.setType(type)
			
		if (y > 0) and (roll == 0): # CHECK TOP BOUNDARY
			checkTile = tiles[y - 1][x]
			if ((randi() % rollMaxInner) == 0):
				checkTile.setType(type)
			
		if (y < TALL - 1) and (roll == 0): # CHECK BOTTOM BOUNDARY
			checkTile = tiles[y + 1][x]
			if ((randi() % rollMaxInner) == 0):
				checkTile.setType(type)


