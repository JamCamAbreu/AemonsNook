extends Node2D

enum tileType { grass, water, tree}

var type = tileType.grass

func setTexture(type):
	match (type):
		tileType.grass:
			get_node("sprite").set_animation("grass")
		tileType.water:
			get_node("sprite").set_animation("water")
		tileType.tree:
			get_node("sprite").set_animation("tree")

func _ready():
	randomize()
	var ran = randi() % 3
	setTexture(ran)
