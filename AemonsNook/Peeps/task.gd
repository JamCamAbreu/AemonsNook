extends Node

# Constructor:
func _ready():
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
	pass





# Movement based, move to inherited class?
var targetTile # the destination tile
var targetSquare # each tile has 4 squares inside of it
var targetDirection # which direction to face for the task