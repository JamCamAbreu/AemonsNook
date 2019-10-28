extends Area2D

var globalMethods = preload("res://Global/globalMethods.gd")
var enums = preload("res://Global/globalEnums.gd")

var target  # Vector2, set by parent
var ready = false
var arrived = false

var buildingType





func _process(delta):
	if (ready and !arrived):
		var newX = globalMethods.Ease(get_position().x, target.x, 0.2)
		var newY = globalMethods.Ease(get_position().y, target.y, 0.2)
		set_position(Vector2(newX, newY))

		if (get_position().distance_to(target) <= 1):
			set_position(target)
			arrived = true


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			ClearSelections()
			SetModes()
			BuildAction()


func BuildAction():
	if (buildingType != null):
		
		if (buildingType == enums.BUILDING_TYPE.ROAD):
			get_node("/root/n2_world").mode = enums.MODE.BUILD_ROAD
		else:
			BeginPlacement(buildingType)



func BeginPlacement(type):
	var worldNode = get_node("/root/n2_world")
	worldNode.mode = enums.MODE.PLACEMENT
	
	var menuResource = load("res://UI/Build/BuildPlacement.tscn")
	var m = menuResource.instance()
	m.CreatePlacement(type)
	worldNode.menu = m
	worldNode.add_child(m)



func ClearSelections():
	for s in get_tree().get_nodes_in_group("Selectors"):
		s.queue_free()

func SetModes():
	get_node("/root/n2_world").mode = enums.MODE.NORMAL
	get_node("/root/n2_world").mouseState = enums.MOUSE_STATE.NONE




func SetBuildingType(type):
	buildingType = type
	match (type):
		enums.BUILDING_TYPE.ARCHERY:
			get_node("backdrop").set_frame(0)
		enums.BUILDING_TYPE.BLACKSMITH:
			get_node("backdrop").set_frame(2)
		enums.BUILDING_TYPE.TAVERN:
			get_node("backdrop").set_frame(14)
		enums.BUILDING_TYPE.BOOTH_PRODUCE:
			get_node("backdrop").set_frame(8)
		enums.BUILDING_TYPE.BOOTH_FISH:
			get_node("backdrop").set_frame(10)
		enums.BUILDING_TYPE.BOOTH_GEMS:
			get_node("backdrop").set_frame(7)
		enums.BUILDING_TYPE.BUTCHER:
			get_node("backdrop").set_frame(3)
		enums.BUILDING_TYPE.STABLES:
			get_node("backdrop").set_frame(12)
		enums.BUILDING_TYPE.TANNER:
			get_node("backdrop").set_frame(13)
		enums.BUILDING_TYPE.SCRIBE:
			get_node("backdrop").set_frame(9)
		enums.BUILDING_TYPE.CHAPEL:
			get_node("backdrop").set_frame(4)
		enums.BUILDING_TYPE.INN:
			get_node("backdrop").set_frame(6)
		enums.BUILDING_TYPE.BOOTH_SEEDS:
			get_node("backdrop").set_frame(11)
		enums.BUILDING_TYPE.BATH:
			get_node("backdrop").set_frame(1)
		enums.BUILDING_TYPE.CLOTH:
			get_node("backdrop").set_frame(5)
		enums.BUILDING_TYPE.ROAD:
			get_node("backdrop").set_frame(15)


func _on_Area2D_mouse_entered():
	get_node("/root/n2_world").mouseState = enums.MOUSE_STATE.INSIDE


func _on_Area2D_mouse_exited():
	get_node("/root/n2_world").mouseState = enums.MOUSE_STATE.OUTSIDE
