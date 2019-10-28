extends Node2D

const enums = preload("res://Global/globalEnums.gd")
const paths = preload("res://Global/globalPaths.gd")


func _ready():
	pass # Replace with function body.






func CreateBuildingSelection(availableTypes):
	var worldNode = get_node(paths.worldNode)
	worldNode.mode = enums.MODE.BUILD
	worldNode.mouseState = enums.MOUSE_STATE.OUTSIDE
	
	var amountNodes = availableTypes.size()
	
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
			cur.SetBuildingType(availableTypes[i])
			cur.target = Vector2(cos(pos)*radius, sin(pos)*radius)
			cur.ready = true
			add_child(cur)
			
	emit_signal("buildModeStarted")

