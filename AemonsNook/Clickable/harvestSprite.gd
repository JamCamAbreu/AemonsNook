extends AnimatedSprite
var enums = preload("res://Global/globalEnums.gd")

var life = 0.4
var upSpeed = 80
var visibility = 0.3

func _ready():
	self.scale.x = 0.75
	self.scale.y = 0.75
	self.set_modulate(Color(1, 1, 1, visibility))

func _process(delta):
	self.position.y -= delta*upSpeed
	life -= delta
	self.scale.x += delta*2.5
	self.scale.y += delta*2.5
	visibility += delta*2
	self.set_modulate(Color(1, 1, 1, visibility))
	if (life <= 0):
		self.queue_free()
		
func setType(type):
	match(type):
		enums.CLICK_TYPE.TREE:
			set_animation("tree")
		enums.CLICK_TYPE.STONE:
			set_animation("stone")