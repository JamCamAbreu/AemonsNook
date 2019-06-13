extends Node2D

enum tileType { grass, water, tree}

var type = tileType.grass

func _setTexture(type):
	match (type):
		tileType.grass:
			get_node("sprite").set_animation("grass")
		tileType.water:
			get_node("sprite").set_animation("water")
		tileType.tree:
			get_node("sprite").set_animation("tree")

func setType(_type):
	type = _type
	_setTexture(_type)