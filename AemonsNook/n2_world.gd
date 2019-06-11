extends Node2D

var WIDE = 40
var TALL = 20
var tiles = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var t = load("res://World/n2_tile.tscn")
	
	var rows = WIDE
	var cols = TALL
	for r in range(rows):
		tiles.append([])
		tiles[r].resize(WIDE)
		
		for c in range(cols):
			var newTile = t.instance()
			newTile.setTexture(newTile.tileType.grass)
			newTile.translate(Vector2(c + 1, r + 1))
			add_child(newTile)
			tiles[r][c] = newTile
			
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
