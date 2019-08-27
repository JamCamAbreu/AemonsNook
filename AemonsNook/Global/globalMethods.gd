extends Node

const enums = preload("res://Global/globalEnums.gd")

static func TILE_GET_SHAPE_NAME(number):
	match (number):
		0:
			return enums.TILE_SHAPE.EMPTY
		1:
			return enums.TILE_SHAPE.HORIZONTAL
		8:
			return enums.TILE_SHAPE.HORIZONTAL
		9:
			return enums.TILE_SHAPE.HORIZONTAL

		2:
			return enums.TILE_SHAPE.VERTICAL
		4:
			return enums.TILE_SHAPE.VERTICAL
		6:
			return enums.TILE_SHAPE.VERTICAL

		12:
			return enums.TILE_SHAPE.UP_LEFT
						
		5:
			return enums.TILE_SHAPE.UP_RIGHT
						
		3:
			return enums.TILE_SHAPE.DOWN_RIGHT
						
		10:
			return enums.TILE_SHAPE.DOWN_LEFT
						
		7:
			return enums.TILE_SHAPE.RIGHT_T
			
		11:
			return enums.TILE_SHAPE.DOWN_T
						
		14:
			return enums.TILE_SHAPE.LEFT_T
						
		13:
			return enums.TILE_SHAPE.UP_T
						
		15:
			return enums.TILE_SHAPE.INTERSECTION
			

