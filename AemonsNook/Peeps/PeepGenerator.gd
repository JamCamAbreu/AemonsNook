extends Node

var enums = preload("res://Global/globalEnums.gd")
var peepScript = preload("res://Peeps/peep.gd")
var peepScene = preload("res://Peeps/Peep.tscn")

var entrances = []
var ready = false
var tilesNode

var spawnSpeedMin = 60*1 # get from map
var spawnSpeedMax = 60*5 # get from map
var curSpawnSpeed = (randi() % (spawnSpeedMax - spawnSpeedMin)) + spawnSpeedMin
var timer = 0

var startingMaxPeeps = 10 # get from map
var maxPeeps = startingMaxPeeps

var peeps = []

# called by sc_world
func Setup(levelNode, tilesNodeid):
	tilesNode = tilesNodeid
	entrances = tilesNode.edgeTiles
	
	#spawnSpeed = levelNode.spawnSpeed
	
	# define waves like tower defense, there can also be a random variance of scattered peeps
	
	# waves should be passed in as an arbitrarily sized array, each element of the 
	# array as a special data structure for 'wave' which includes a time that the wave
	# kicks off, and information about what to spawn.
	ready = true


func _ready():
	pass

func _process(delta):
	if (ready):
		timer += 1
		
		var type
		if (timer > curSpawnSpeed && peeps.size() < maxPeeps):
			type = randi() % enums.PEEP_TYPE.size()
			createPeepEntrance(type)
			resetPeepTimer()

func resetPeepTimer():
	curSpawnSpeed = (randi() % (spawnSpeedMax - spawnSpeedMin)) + spawnSpeedMin
	timer = 0


func createPeepEntrance(_type):
	var rand = randi() % entrances.size()
	var tile = entrances[rand]
	
	var curPeep = peepScene.instance()
	curPeep.init(_type, tile, tilesNode)
	peeps.append(curPeep)
	self.add_child(curPeep)

