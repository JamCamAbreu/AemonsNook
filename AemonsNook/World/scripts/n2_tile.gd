extends Node2D

enum TILETYPE { GRASS, WATER, TREE, DIRT}
enum CLICKABLETYPE { TREE, STONE }

var type = TILETYPE.GRASS
var seedID = "none"
var clickable
var hasClickable = false


func clickable_clicked_received():
	destroyClickable()

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
	
func createClickable(type):
	if (hasClickable == false):
		match (type):
			CLICKABLETYPE.TREE:
				var t = load("res://Clickable/click-resources/sc_clickable.tscn")
				var newClickable = t.instance()
				add_child(newClickable)
				newClickable.connect("clicked", self, "clickable_clicked_received")
				clickable = newClickable
				hasClickable = true
			
func destroyClickable():
	if (hasClickable):
		clickable.queue_free()
		
