extends Node2D


var valid = false


func _ready():
	pass # Replace with function body.


func GetValidity():
	return valid

func SetValid(validity):
	valid = validity
	if (valid == true):
		get_node("AnimatedSprite").set_animation("valid")
	else:
		get_node("AnimatedSprite").set_animation("invalid")