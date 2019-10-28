extends Node
var enums = preload("res://Global/globalEnums.gd")

# todo: make the clickables code set these,
# then, make the UI pull data from here instead

var wood
var stone
var food

var researchUnlocked = []
var buildingsUnlocked = []

func AddResearch(type):
	researchUnlocked.append(type)

func AddBuilding(type):
	buildingsUnlocked.append(type)

func GetResearchUnlocked():
	return researchUnlocked
	
func GetBuildingsUnlocked():
	return buildingsUnlocked
