extends Area2D
signal clicked

const HARVEST_SCENE = preload("res://Clickable/harvestSprite.tscn")
var enums = preload("res://Global/globalEnums.gd")

var type
var health = 1
var harvestAmount = 1



#func _ready():
	

func setHealth(modify):
	match (type):
		enums.CLICK_TYPE.TREE:
			health = 5 * modify
		enums.CLICK_TYPE.STONE:
			health = 7 * modify


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			_createHarvestSprite()
			emit_signal("clicked", self)


func _setType(_type):
	type = _type
	match (type):
		enums.CLICK_TYPE.TREE:
			get_node("sprite").set_animation("tree")
			var randScale = rand_range(0.75, 1.5)
			get_node("sprite").set_scale(Vector2(randScale, randScale))
			harvestAmount = 3
			setHealth(randScale) # trees worth more larger they are
			
		enums.CLICK_TYPE.STONE:
			get_node("sprite").set_animation("stone")
			harvestAmount = 1
			setHealth(1)
	
func _createHarvestSprite():
	var hs = HARVEST_SCENE.instance()
	add_child(hs)
	hs.setType(type)
	hs.set_z_index(get_z_index() + 10)
	

func harvest():
	health -= 1
	if (health <= 0):
		self.queue_free()


func setDebug(string):
	get_node("debug").set_text(str(string))
