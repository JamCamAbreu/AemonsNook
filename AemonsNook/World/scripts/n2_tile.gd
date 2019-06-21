extends Node2D
const CLICK_SCRIPT = preload("res://Clickable/scripts/clickableArea.gd")

enum TILETYPE { GRASS, WATER, TREE, DIRT}

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
		var t = load("res://Clickable/click-resources/sc_clickable.tscn")
		var newClickable = t.instance()
		newClickable._setType(type)
		add_child(newClickable)
		newClickable.connect("clicked", self, "clickable_clicked_received")
		clickable = newClickable
		hasClickable = true


func destroyClickable():
	if (hasClickable):
		var loc = "/root/n2_world/GUI/HBoxContainer/Bars/Bar/WoodCounter/counterBg/counterCount"
		var inc = int(get_node(loc).get_text()) + 1
		get_node(loc).set_text(str(inc))
		clickable.queue_free()
