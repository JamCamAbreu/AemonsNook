extends Node
var enums = preload("res://Global/globalEnums.gd")

# todo: make the clickables code set these,
# then, make the UI pull data from here instead

var wood
var stone
var food

var researchUnlocked = []

func AddResearch(type):
	researchUnlocked.append(type)


