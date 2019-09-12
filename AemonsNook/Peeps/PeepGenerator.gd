extends Node

var enums = preload("res://Global/globalEnums.gd")
var peepScript = preload("res://Peeps/peep.gd")
var peepScene = preload("res://Peeps/Peep.tscn")

var entrances = []
var ready = false
var tilesNode

var peeps = []

var done = false

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
	if (ready and !done):
		var type
		for i in range(10):
			type = randi() % enums.PEEP_TYPE.size()
			createPeepEntrance(type)
		done = true



func createPeepEntrance(_type):
	var rand = randi() % entrances.size()
	var tile = entrances[rand]
	
	var curPeep = peepScene.instance()
	curPeep.init(_type, tile, tilesNode)
	peeps.append(curPeep)
	self.add_child(curPeep)

