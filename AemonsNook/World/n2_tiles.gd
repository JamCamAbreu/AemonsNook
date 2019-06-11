extends Node2D


var WIDE = 40
var TALL = 20
var tiles = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var t = load("res://World/n2_tile.tscn")
	
	var rows = TALL
	var cols = WIDE
	for r in range(rows):
		tiles.append([])
		tiles[r].resize(WIDE)
		
		for c in range(cols):
			var newTile = t.instance()
			newTile.setTexture(newTile.tileType.grass)
			newTile.translate(Vector2(c * 16, r * 16))
			add_child(newTile)
			
	