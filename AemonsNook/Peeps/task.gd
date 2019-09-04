extends Node

var enums = preload("res://Global/globalEnums.gd")

# Constructor:
func init(args):
	taskType = args[0]
	match args[0]:# ARG 0 is always the task type
		enums.TASK_TYPE.WALK:
			targetTile = args[1]
			targetSquare = args[2]
			targetDirection = args[3]
		enums.TASK_TYPE.SEEK_FOOD:
			pass
		enums.TASK_TYPE.SEEK_REST:
			pass
		enums.TASK_TYPE.EXIT:
			pass
		enums.TASK_TYPE.SEEK_BRAWL:
			pass
		enums.TASK_TYPE.POOP:
			pass
		enums.TASK_TYPE.SEEK_TAVERN:
			pass
		enums.TASK_TYPE.SEEK_BATHROOM:
			pass
		enums.TASK_TYPE.SEEK_BLACKSMITH:
			pass


# Member variables:
var taskType
var complete = false
var completeCounter = 0
var completeDelaySeconds = 1

var fatigueCost = 1 # default, but can change

func _process(delta):
	
	# task complete, begin delay before next task:
	if (complete):
		if (completeCounter < completeDelaySeconds*60):
			completeCounter += 1
		else:
			cleanup()

func cleanup():
	emit_signal("taskComplete", self)


# Movement based, move to inherited class?
var targetTile # the destination tile
var targetSquare # each tile has 4 squares inside of it
var targetDirection # which direction to face for the task