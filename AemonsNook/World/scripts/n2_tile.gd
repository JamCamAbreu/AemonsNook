extends Node2D
const enums = preload("res://Global/globalEnums.gd")
const paths = preload("res://Global/globalPaths.gd")
#const CLICK_SCRIPT = preload("res://Clickable/scripts/clickableArea.gd")

var woodCounter
var stoneCounter

var tileset_id

var type = enums.TILETYPE.GRASS
var seedID = "none"
var clickable
var hasClickable = false

func _ready():
	woodCounter = get_node(paths.woodCounter)
	stoneCounter = get_node(paths.stoneCounter)
	tileset_id = 0 # default

func clickable_clicked_received():
	destroyClickable()

func _setTexture(type):
	match (type):
		enums.TILETYPE.GRASS:
			get_node("sprite").set_animation("grass")
		enums.TILETYPE.WATER:
			get_node("sprite").set_animation("water")
		enums.TILETYPE.TREE:
			get_node("sprite").set_animation("tree")
		enums.TILETYPE.DIRT:
			get_node("sprite").set_animation("dirt")

func setType(_type):
	type = _type
	_setTexture(_type)
	

func setSprite(spriteId):
	var label = get_node("debugLabel")
	label.set_text(str(spriteId))

	
func createClickable(type):
	if (hasClickable == false):
		
		var t = load(globalPaths.clickableScene)
		var newClickable = t.instance()
		newClickable._setType(type)
		add_child(newClickable)
		newClickable.connect("clicked", self, "clickable_clicked_received")
		clickable = newClickable
		hasClickable = true


func calcAmount(node, amount):
	return int(node.get_text()) + amount

func addAmount(type, amount):
	match (clickable.type):
		enums.CLICK_TYPE.TREE:
			var a = calcAmount(woodCounter, amount)
			woodCounter.set_text(str(a))
			
		enums.CLICK_TYPE.STONE:
			var a = calcAmount(stoneCounter, amount)
			stoneCounter.set_text(str(a))


func destroyClickable():
	if (hasClickable):
		addAmount(clickable.type, clickable.harvestAmount)
		clickable.harvest()
		
