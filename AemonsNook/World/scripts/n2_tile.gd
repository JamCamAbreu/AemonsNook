extends Node2D
const enums = preload("res://Global/globalEnums.gd")
const paths = preload("res://Global/globalPaths.gd")
const effect = preload("res://World/Effects/Effect.tscn")
#const CLICK_SCRIPT = preload("res://Clickable/scripts/clickableArea.gd")

var woodCounter
var stoneCounter

var topAnimation = "none"

var isBuildZone

var tileset_id

var type = enums.TILETYPE.GRASS
var seedID = "none"

func _ready():
	woodCounter = get_node(paths.woodCounter)
	stoneCounter = get_node(paths.stoneCounter)
	tileset_id = 0 # default
	isBuildZone = false


func SetBuildZone():
	isBuildZone = true




func clickable_clicked_received(obj):
	harvestClickable(obj)

func _setTexture(type):
	match (type):
		enums.TILETYPE.GRASS:
			get_node("bottomLayer").set_animation("none")
			get_node("middleLayer").set_animation("grass")
			get_node("topLayer").set_animation("none")
			topAnimation = "none"
		enums.TILETYPE.WATER:
			get_node("bottomLayer").set_animation("grass")
			get_node("middleLayer").set_animation("dirt")
			get_node("topLayer").set_animation("water")
			topAnimation = "water"
		enums.TILETYPE.TREE:
			get_node("bottomLayer").set_animation("none")
			get_node("middleLayer").set_animation("grass")
			get_node("topLayer").set_animation("none")
			topAnimation = "none"
		enums.TILETYPE.DIRT:
			get_node("bottomLayer").set_animation("none")
			get_node("middleLayer").set_animation("dirt")
			get_node("topLayer").set_animation("none")
			topAnimation = "none"
			

func setType(_type):
	type = _type
	_setTexture(_type)
	

func setSprite(spriteId):
	#var label = get_node("debugLabel")
	#label.set_text(str(spriteId))
	
	if (type == enums.TILETYPE.DIRT):
		get_node("middleLayer").set_frame(spriteId)
		get_node("bottomLayer").set_frame(spriteId)
		
	elif (type == enums.TILETYPE.WATER):
		get_node("middleLayer").set_frame(spriteId)
		get_node("bottomLayer").set_frame(spriteId)




func growTrees(spriteId):
	match spriteId:
		
		#  1 = all the way right/bottom
		# -1 = all the way left/top
		#  0 = in the middle
		
		# Single
		0:
			createClickablePos(enums.CLICK_TYPE.TREE, 0, 0) 
			
		# Horz Line
		1, 8, 9:
			for i in range(3):
				var randX = rand_range(-0.8, 0.8)
				var randY = rand_range(-0.3, 0.3)
				createClickablePos(enums.CLICK_TYPE.TREE, randX, randY) 
			
		# Vert Line
		2, 4, 6:
			for i in range(3):
				var randX = rand_range(-0.3, 0.3)
				var randY = rand_range(-0.8, 0.8)
				createClickablePos(enums.CLICK_TYPE.TREE, randX, randY) 
			
		# Up Left Corner
		12:
			createClickablePos(enums.CLICK_TYPE.TREE, 0, 0) 
			
		# Up Right Corner
		5:
			createClickablePos(enums.CLICK_TYPE.TREE, 0, 0) 
		
		# Down Right Corner
		3:
			createClickablePos(enums.CLICK_TYPE.TREE, 0, 0) 
			
		# Down Left Corner
		10:
			createClickablePos(enums.CLICK_TYPE.TREE, 0, 0) 
	
		# Right T
		7:
			createClickablePos(enums.CLICK_TYPE.TREE, 0, 0) 
	
		# Down T
		11:
			createClickablePos(enums.CLICK_TYPE.TREE, 0, 0) 
	
		# Left T
		14:
			createClickablePos(enums.CLICK_TYPE.TREE, 0, 0) 
	
		# Up T
		13:
			createClickablePos(enums.CLICK_TYPE.TREE, 0, 0) 
	
		# All sides (dense)
		15:
			var randNum = randi() % 3 + 3
			for i in range(randNum):
				var randX = rand_range(-0.8, 0.8)
				var randY = rand_range(-0.8, 0.8)
				createClickablePos(enums.CLICK_TYPE.TREE, randX, randY) 
	
	



	
func createClickable(type):
	var t = load(globalPaths.clickableScene)
	var newClickable = t.instance()
	newClickable._setType(type)
	var spriteNum = randi() % enums.NUM_TREE_SPRITES
	newClickable.get_node("sprite").set_frame(spriteNum)
	add_child(newClickable)
	newClickable.connect("clicked", self, "clickable_clicked_received")


func createClickablePos(type, xTranslation, yTranslation):
	var t = load(globalPaths.clickableScene)
	var newClickable = t.instance()
	newClickable._setType(type)
	var spriteNum = randi() % enums.NUM_TREE_SPRITES
	newClickable.get_node("sprite").set_frame(spriteNum)
	newClickable.translate(Vector2(enums.TILE_SIZE_PIXELS/2 * xTranslation, enums.TILE_SIZE_PIXELS/2 * yTranslation))
	var index = int(get_position().y + ((yTranslation + 1)*2))
	newClickable.set_z_index(index)
	#newClickable.setDebug(index)
	add_child(newClickable)
	newClickable.connect("clicked", self, "clickable_clicked_received")


func calcAmount(node, amount):
	return int(node.get_text()) + amount

func addAmount(type, amount):
	match (type):
		enums.CLICK_TYPE.TREE:
			var a = calcAmount(woodCounter, amount)
			woodCounter.set_text(str(a))
			
		enums.CLICK_TYPE.STONE:
			var a = calcAmount(stoneCounter, amount)
			stoneCounter.set_text(str(a))


func harvestClickable(obj):
		addAmount(obj.type, obj.harvestAmount)
		obj.harvest()
		


func createWaterSparkle():
	var t = effect.instance()
	add_child(t)




func _on_Area2D_mouse_entered():
	pass # Replace with function body.


func _on_Area2D_mouse_exited():
	pass # Replace with function body.
