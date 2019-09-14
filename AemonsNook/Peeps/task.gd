extends Node

var enums = preload("res://Global/globalEnums.gd")


# Constructor:
func _init(args):
	taskType = args[0]
	match args[0]:# ARG 0 is always the task type
		enums.TASK_TYPE.WALK:
			targetTile = args[1]
			targetSquare = args[2]
			targetDirection = args[3]
			ConstructTileQueue(args[4], args[5]) #curtile, pathTiles
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







var generatedPath = []


var targetTile # the destination tile
var targetSquare # each tile has 4 squares inside of it
var targetDirection # which direction to face for the task
func ConstructTileQueue(startTile, pathTiles):
	var visitedTiles = {} # dictionary
	visitedTiles[startTile] = null
	var tileQueue = []
	generatedPath.clear()
	
	tileQueue.append(startTile)
	var cur							# note: use PAIRS for 'visited'
	while (tileQueue.size() > 0):	# 0: tile, 1: fromTile
		cur = tileQueue.front()
		tileQueue.pop_front()
		
		# Target has been found
		if (cur == targetTile):
			generatedPath.append(cur)
			var to = cur
			var from = visitedTiles[to]
			while (from != startTile):
				generatedPath.append(from)
				to = from
				from = visitedTiles[to] # BUG: sometimes visitedTiles[to] is null
										# is it because target tile is current tile?
			#DEBUG
			for t in generatedPath:
				t.DebugSetCurPathImage(t == targetTile)
			return

		# push all neighbors we have not yet visited
		var t = cur.tileAbove
		if (t != null && !visitedTiles.has(t) && t.type == enums.TILETYPE.DIRT):
			tileQueue.append(t)
			visitedTiles[t] = cur #to, from
			
		t = cur.tileRight
		if (t != null && !visitedTiles.has(t) && t.type == enums.TILETYPE.DIRT):
			tileQueue.append(t)
			visitedTiles[t] = cur #to, from
			
		t = cur.tileBelow
		if (t != null && !visitedTiles.has(t) && t.type == enums.TILETYPE.DIRT):
			tileQueue.append(t)
			visitedTiles[t] = cur #to, from
			
		t = cur.tileLeft
		if (t != null && !visitedTiles.has(t) && t.type == enums.TILETYPE.DIRT):
			tileQueue.append(t)
			visitedTiles[t] = cur #to, from



func GetNextTileFromQueue():
	if (generatedPath != null):
		var nextTile = generatedPath.back()
		generatedPath.pop_back()
		return nextTile
	pass
