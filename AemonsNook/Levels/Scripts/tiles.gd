extends Node2D

var enums = preload("res://Global/globalEnums.gd")
#const TILE_SCRIPT = preload("res://World/scripts/n2_tile.gd")
const CLICK_SCRIPT = preload("res://Clickable/scripts/clickableArea.gd")

const TILE_SIZE_PIXELS = 16
var tiles = []

#enum MAPSIDE { TOP, RIGHT, BOTTOM, LEFT }
#const GROW_ALL = "all"

onready var tt = get_node("tileTimer")
func _wait(seconds):
	tt.set_wait_time(seconds)
	tt.set_one_shot(true)
	tt.start()

# Global use functions:
#func GetMapWidth():
	#return (WIDE*TILE_SIZE_PIXELS)
#func GetMapHeight():
	#return (TALL*TILE_SIZE_PIXELS)


#func _ready():
	#_generateTiles(TILE_SCRIPT.TILETYPE.GRASS)
	