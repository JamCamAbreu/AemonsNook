extends Node2D

var enums = preload("res://Global/globalEnums.gd")

var enterEdgeId
var exitEdgeId

var myTasks

var fatiguePoints  # number of tasks before tired and wants to leave

var firstName
var Surname
var age
var role
var sex

var copper
var silver
var gold


func _ready():
	get_node("Head").set_frame(randi() % get_node("Head").get_sprite_frames().get_frame_count("default"))

func _init(_role):
	role = _role
	SetSex(_role)
	SetFirstName()
	SetSurname(_role)


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
		firstName = enums.GetEnumName(enums.PEEP_MALE_FNAMES)
	else:
		firstName = enums.GetEnumName(enums.PEEP_FEMALE_FNAMES)

func SetSurname(_role):
	var fame = GetFame(_role)
	
	# COMMONER:
	if (fame <= 10):
		Surname = enums.GetEnumName(enums.SIRNAMES_COMMON)

	# MIDDLE CLASS:
	elif (fame <= 20):
		Surname = enums.GetEnumName(enums.SIRNAMES_MIDDLE)

	# ROYAL:
	else:
		Surname = enums.GetEnumName(enums.SIRNAMES_ROYAL)

func GetFame(_role):
	match _role:
		enums.HOMELESS:
			return 1
		enums.THIEF:
			return 1
		enums.FARMER:
			return 3
		enums.TRADER:
			return 5
		enums.MONK:
			return 6
		enums.NUN:
			return 6
		enums.FOREIGNER:
			return 7
		enums.ELDER:
			return 7
		enums.PRIEST:
			return 9
		enums.KNIGHT:
			return 12
		enums.WITCH:
			return 12
		enums.BARD:
			return 13
		enums.QUESTER:
			return 14
		enums.WIZARD:
			return 16
		enums.BISHOP:
			return 20
		enums.LADY:
			return 25
		enums.KING:
			return 30

func GenerateTasks(_role):
	pass
