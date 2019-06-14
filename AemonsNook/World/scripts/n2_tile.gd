extends Node2D

enum TILETYPE { GRASS, WATER, TREE, DIRT}

var type = TILETYPE.GRASS

func _setTexture(type):
	match (type):
		TILETYPE.GRASS:
			get_node("sprite").set_animation("grass")
		TILETYPE.WATER:
			get_node("sprite").set_animation("water")
		TILETYPE.TREE:
			get_node("sprite").set_animation("tree")
		TILETYPE.DIRT:
			get_node("sprite").set_animation("dirt")

func setType(_type):
	type = _type
	_setTexture(_type)