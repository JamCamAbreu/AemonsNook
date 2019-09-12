extends Node2D

var enums = preload("res://Global/globalEnums.gd")
var taskScript = preload("res://Peeps/task.gd")
var tiles

var ready = false

var enterEdgeId
var exitEdgeId

var myTasks = []
var currentTask

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


func _process(delta):
	if (ready):
		pass



# -- Tasks --
func Move():
	pass
	
func AskNextTile():
	pass
	
func CheckDestinationReached():
	pass

func CheckInterrupt():
	pass
	
func NextTask():
	pass

func GetCurTile():
	pass



# -- Setup and Constructor --
func init(_role, enterEdge, _tiles):	# role = PEEP_TYPE
	role = _role
	SetSex(_role)
	SetFirstName()
	SetSurname(_role)
	enterEdgeId = enterEdge
	set_position(enterEdgeId.getPos())
	tiles = _tiles


func GenerateTasks(_role):
	# regardless of role, always generate some starting movement:
	var targetTile = tiles.pathTiles[randi() % tiles.pathTiles.size()]
	var t = NewWalkTask(targetTile)
	get_node("/root/n2_world/DebugMenu").numTasks += 1
	myTasks.append(t)
	
func _ready():
	tiles = get_node("/root/n2_world/n2_tiles")
	get_node("Head").set_frame(randi() % get_node("Head").get_sprite_frames().get_frame_count("default"))
	GenerateTasks(role)
	#currentTask = myTasks[0]
	ready = true

func NewWalkTask(tile):
	var args = []
	args.append(enums.TASK_TYPE.WALK)
	args.append(tile)
	args.append(enums.TILE_SQUARE.TOPLEFT)
	args.append(enums.DIRECTION.UP)
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
