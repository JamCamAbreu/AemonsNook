extends Node2D
const enums = preload("res://Global/globalEnums.gd")
const paths = preload("res://Global/globalPaths.gd")
const effect = preload("res://World/Effects/Effect.tscn")
#const CLICK_SCRIPT = preload("res://Clickable/scripts/clickableArea.gd")

var woodCounter
var stoneCounter

var topAnimation = "none"

var tileAbove
var tileRight
var tileBelow
var tileLeft


# Peeps
var mapEdge = false
var mapEdgeId = -1

var isBuildZone

var tileset_id

var type = enums.TILETYPE.GRASS
var seedID = "none"

func _ready():
	woodCounter = get_node(paths.woodCounter)
	stoneCounter = get_node(paths.stoneCounter)
	tileset_id = 0 # default
	isBuildZone = false



func getPos():
	return position


func IsBuildable():
	if (type == enums.TILETYPE.GRASS):
		return true
	else:
		return false





func CreateBuildUI():
	var worldNode = get_node(paths.worldNode)
	worldNode.mode = enums.MODE.BUILD
	worldNode.mouseState = enums.MOUSE_STATE.OUTSIDE
	var amountNodes = worldNode.debugNodeNum
	if (amountNodes == 8):
		worldNode.debugNodeNum = 1
	else:
		worldNode.debugNodeNum = amountNodes + 1
	
	var bs = load(globalPaths.buildSelection)
	
	var radius = 45  # distance in pixels
	var centerAngle = -90 # degrees
	var spaceAmount = 45  # degrees
	var maxNodes =  360/spaceAmount
	var spread = (amountNodes - 1)*spaceAmount
	for i in amountNodes:
		if (i + 1 <= maxNodes):
			var cur = bs.instance()
			var pos = deg2rad(centerAngle - (spread/2) + (spaceAmount*i))
			cur.SetImage(randi() % 15)
			cur.target = Vector2(cos(pos)*radius, sin(pos)*radius)
			cur.ready = true
			add_child(cur)
			
	emit_signal("buildModeStarted")






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
			get_node("bottomLayer").set_animation("grass")
			get_node("middleLayer").set_animation("dirt")
			get_node("topLayer").set_animation("none")
			topAnimation = "none"
		enums.TILETYPE.STONE:
			get_node("bottomLayer").set_animation("none")
			get_node("middleLayer").set_animation("grass")
			get_node("topLayer").set_animation("none")
			topAnimation = "none"
		enums.TILETYPE.BUILDING:
			get_node("bottomLayer").set_animation("grass")
			get_node("middleLayer").set_animation("dirt")
			get_node("topLayer").set_animation("none")
			topAnimation = "none"


func setType(_type):
	type = _type
	_setTexture(_type)
	
	



	
func DebugSetCurPathImage(isTarget):
	get_node("topLayer").set_animation("hover")
	if (isTarget):
		get_node("topLayer").set_frame(0)
	else:
		get_node("topLayer").set_frame(1)

func DebugClearPathImage():
	get_node("topLayer").set_animation("none")

func DebugSetNextPathImage():
	get_node("topLayer").set_animation("hover")
	get_node("topLayer").set_frame(2)

func setSprite(spriteId):
	#var label = get_node("debugLabel")
	#label.set_text(str(spriteId))
	
	if (type == enums.TILETYPE.DIRT || type == enums.TILETYPE.BUILDING):
		get_node("middleLayer").set_frame(spriteId)
		get_node("bottomLayer").set_frame(spriteId)
		
	elif (type == enums.TILETYPE.WATER):
		get_node("middleLayer").set_frame(spriteId)
		get_node("topLayer").set_frame(spriteId)




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




func growStones(spriteId):
	match spriteId:
		
		#  1 = all the way right/bottom
		# -1 = all the way left/top
		#  0 = in the middle
		
		# Single
		0:
			createClickablePos(enums.CLICK_TYPE.STONE, 0, 0) 
			
		# Horz Line
		1, 8, 9:
			for i in range(3):
				var randX = rand_range(-0.8, 0.8)
				var randY = rand_range(-0.3, 0.3)
				createClickablePos(enums.CLICK_TYPE.STONE, randX, randY) 
			
		# Vert Line
		2, 4, 6:
			for i in range(3):
				var randX = rand_range(-0.3, 0.3)
				var randY = rand_range(-0.8, 0.8)
				createClickablePos(enums.CLICK_TYPE.STONE, randX, randY) 
			
		# Up Left Corner
		12:
			createClickablePos(enums.CLICK_TYPE.STONE, 0, 0) 
			
		# Up Right Corner
		5:
			createClickablePos(enums.CLICK_TYPE.STONE, 0, 0) 
		
		# Down Right Corner
		3:
			createClickablePos(enums.CLICK_TYPE.STONE, 0, 0) 
			
		# Down Left Corner
		10:
			createClickablePos(enums.CLICK_TYPE.STONE, 0, 0) 
	
		# Right T
		7:
			createClickablePos(enums.CLICK_TYPE.STONE, 0, 0) 
	
		# Down T
		11:
			createClickablePos(enums.CLICK_TYPE.STONE, 0, 0) 
	
		# Left T
		14:
			createClickablePos(enums.CLICK_TYPE.STONE, 0, 0) 
	
		# Up T
		13:
			createClickablePos(enums.CLICK_TYPE.STONE, 0, 0) 
	
		# All sides (dense)
		15:
			var randNum = randi() % 2 + 1
			for i in range(randNum):
				var randX = rand_range(-0.8, 0.8)
				var randY = rand_range(-0.8, 0.8)
				createClickablePos(enums.CLICK_TYPE.STONE, randX, randY) 











	
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
	
	# SET SPRITE FRAME
	var spriteNum
	if (type == enums.CLICK_TYPE.TREE):
		spriteNum = randi() % enums.NUM_TREE_SPRITES
	elif (type == enums.CLICK_TYPE.STONE):
		spriteNum = randi() % enums.NUM_STONE_SPRITES
	newClickable.get_node("sprite").set_frame(spriteNum)
	
	# Move to position
	newClickable.translate(Vector2(enums.TILE_SIZE_PIXELS/2 * xTranslation, enums.TILE_SIZE_PIXELS/2 * yTranslation))
	
	# Z index:
	var index = int(get_position().y + ((yTranslation + 1)*2))
	newClickable.set_z_index(index)
	
	# DEBUG:
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



func _on_Area2D_input_event(viewport, event, shape_idx):
	var worldNode = get_node(paths.worldNode)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if (isBuildZone && (worldNode.mode == enums.MODE.BUILD_ROAD)):
				CreateBuildUI()
