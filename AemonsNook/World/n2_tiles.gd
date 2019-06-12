extends Node2D

# get enum from tile:
const tileScript = preload("res://World/scripts/n2_tile.gd")

var WIDE = 40
var TALL = 20
var tiles = []

# Called when the node enters the scene tree for the first time.
func _ready():
	_generateTiles(tileScript.tileType.tree)
	_seed(tileScript.tileType.grass, 20)


func _generateTiles(type):
	var t = load("res://World/n2_tile.tscn")
	var rows = TALL
	var cols = WIDE
	for r in range(rows):
		tiles.append([])
		tiles[r].resize(WIDE)
		for c in range(cols):
			var newTile = t.instance()
			newTile.setTexture(type)
			newTile.translate(Vector2(c * 16, r * 16))
			add_child(newTile)
			tiles[r][c] = newTile


func _seed(type, amount):
	randomize()
	var centerX = WIDE/2
	var centerY = TALL/2
	var reachX = int(WIDE*0.85)
	var reachY = int(TALL*0.5)
	for a in range(amount):
		var ranX = centerX + ((randi() % reachX) - reachX/2)
		var ranY = centerY + ((randi() % reachY) - reachY/2)
		tiles[ranY][ranX].setTexture(type)



