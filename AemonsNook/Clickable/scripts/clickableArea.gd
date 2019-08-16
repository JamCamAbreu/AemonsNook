extends Area2D
signal clicked

const HARVEST_SCENE = preload("res://Clickable/harvestSprite.tscn")
var enums = preload("res://Global/globalEnums.gd")

var type
var health
var harvestAmount = 1

func _ready():
	setHealth()

func setHealth():
	match (type):
		enums.CLICK_TYPE.TREE:
			health = 5
		enums.CLICK_TYPE.STONE:
			health = 7


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			_createHarvestSprite()
			emit_signal("clicked")


func _setType(_type):
	type = _type
	match (type):
		enums.CLICK_TYPE.TREE:
			get_node("sprite").set_animation("tree")
			harvestAmount = 3
			
		enums.CLICK_TYPE.STONE:
			get_node("sprite").set_animation("stone")
			harvestAmount = 1
	setHealth()
	
func _createHarvestSprite():
	var hs = HARVEST_SCENE.instance()
	get_parent().add_child(hs)
	hs.setType(type)
	

func harvest():
	health -= 1
	if (health <= 0):
		self.queue_free()


func setDebug(string):
	get_node("debug").set_text(str(string))
