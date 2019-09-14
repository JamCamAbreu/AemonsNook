extends Node2D

var enums = preload("res://Global/globalEnums.gd")
var globalMethods = preload("res://Global/globalMethods.gd")
var taskScript

var tiles

var ready = false

var enterEdgeId
var exitEdgeId

const WAIT_TIME = 1
var curWaitTime = 0

var myTasks = []
var currentTask
var curTile
var nextTile
var targetTile

var fatiguePoints  # tasks cost fatigue points; points before tired and wants to leave

var firstName
var Surname
var age
var role
var sex

# NOT YET IMPLEMENTED:
var copper
var silver
var gold

var moveSpeed
var focus # how many tiles to walk before 'open' to new tasks





# -- Tasks --	

func CheckInterrupt():
	pass
	
func NextTask():
	pass




# -- Setup and Constructor --
func init(_role, enterEdge, _tiles):	# role = PEEP_TYPE
	role = _role
	SetSex(_role)
	SetFirstName()
	SetSurname(_role)
	enterEdgeId = enterEdge
	curTile = enterEdge
	nextTile = null
	set_position(enterEdgeId.getPos())
	tiles = _tiles


func GenerateTasks(_role):
	# regardless of role, always generate some starting movement:
	var targetTile = tiles.pathTiles[randi() % tiles.pathTiles.size()]
	while (targetTile == curTile):
		targetTile = tiles.pathTiles[randi() % tiles.pathTiles.size()]
	var t = NewWalkTask(targetTile)
	
	
	get_node("/root/n2_world/DebugMenu").numTasks += 1
	myTasks.append(t)


func _ready():
	taskScript = load("res://Peeps/task.gd")
	tiles = get_node("/root/n2_world/n2_tiles")
	get_node("Head").set_frame(randi() % get_node("Head").get_sprite_frames().get_frame_count("default"))
	GenerateTasks(role)
	currentTask = myTasks[0]
	ready = true




func _process(delta):
	if (ready):
		
		curWaitTime += 1
		
		if (curWaitTime > WAIT_TIME && currentTask != null && currentTask.taskType == enums.TASK_TYPE.WALK):
			curWaitTime = 0
			var result = Walk()
			if (result == true):
				currentTask = null # TODO, get next task or go home
				myTasks.remove(0)

		if (currentTask == null):
			if (myTasks.size() == 0):
				
				# new walk task
				var targetTile = tiles.pathTiles[randi() % tiles.pathTiles.size()]
				GenerateTasks(role)
				
			else:
				currentTask = myTasks[0]








const CLOSING_GAP = 3
func Walk():

	if (nextTile == null || curTile == nextTile):
		if (currentTask.generatedPath.size() > 0):
			nextTile = currentTask.GetNextTileFromQueue()
			nextTile.DebugSetNextPathImage()
		else:
			return true # true means we are finished with task

	var moveToPos = nextTile.getPos()
	if (position.distance_to(moveToPos) <= CLOSING_GAP):
		position = moveToPos
		curTile.DebugClearPathImage()
		curTile = nextTile
		return false # true means we are finished with task
		
	else:
		var newX = globalMethods.Ease(get_position().x, moveToPos.x, 0.1)
		var newY = globalMethods.Ease(get_position().y, moveToPos.y, 0.1)	
		set_position(Vector2(newX, newY))
		#get_node("/root/n2_world/playerView").set_position(position)
		return false # false means keep walking


func NewWalkTask(tile):
	var args = []
	args.append(enums.TASK_TYPE.WALK)
	args.append(tile)
	args.append(enums.TILE_SQUARE.TOPLEFT)
	args.append(enums.DIRECTION.UP)
	args.append(curTile)
	args.append(tiles.pathTiles)
	return taskScript.new(args)



# -- Characteristics --
func SetSex(_role):
	# A few roles are sex-specific:
	if (_role == enums.PEEP_TYPE.LADY || 
	    _role == enums.PEEP_TYPE.NUN ||
        _role == enums.PEEP_TYPE.WITCH):
		sex = enums.SEX.FEMALE

	elif (_role == enums.PEEP_TYPE.LORD ||
	         _role == enums.PEEP_TYPE.MONK ||
             _role == enums.PEEP_TYPE.WIZARD):
        sex = enums.SEX.MALE

	else:
		sex = enums.SEX.MALE if ((randi() % 2) == 0) else enums.SEX.FEMALE

func SetFirstName():
	if (sex == enums.SEX.MALE):
		firstName = enums.GetNameRandom(enums.PEEP_MALE_FNAMES)
	else:
		firstName = enums.GetNameRandom(enums.PEEP_FEMALE_FNAMES)

func SetSurname(_role):
	var fame = GetFame(_role)
	
	# COMMONER:
	if (fame <= 10):
		Surname = enums.GetNameRandom(enums.SIRNAMES_COMMON)

	# MIDDLE CLASS:
	elif (fame <= 20):
		Surname = enums.GetNameRandom(enums.SIRNAMES_MIDDLE)

	# ROYAL:
	else:
		Surname = enums.GetNameRandom(enums.SIRNAMES_ROYAL)

func GetFame(_role):
	match _role:
		enums.PEEP_TYPE.HOMELESS:
			return 1
		enums.PEEP_TYPE.THIEF:
			return 1
		enums.PEEP_TYPE.FARMER:
			return 3
		enums.PEEP_TYPE.TRADER:
			return 5
		enums.PEEP_TYPE.MONK:
			return 6
		enums.PEEP_TYPE.NUN:
			return 6
		enums.PEEP_TYPE.FOREIGNER:
			return 7
		enums.PEEP_TYPE.ELDER:
			return 7
		enums.PEEP_TYPE.PRIEST:
			return 9
		enums.PEEP_TYPE.KNIGHT:
			return 12
		enums.PEEP_TYPE.WITCH:
			return 12
		enums.PEEP_TYPE.BARD:
			return 13
		enums.PEEP_TYPE.QUESTER:
			return 14
		enums.PEEP_TYPE.WIZARD:
			return 16
		enums.PEEP_TYPE.BISHOP:
			return 20
		enums.PEEP_TYPE.LADY:
			return 25
		enums.PEEP_TYPE.KING:
			return 30
		_:
			return -1
