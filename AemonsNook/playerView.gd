extends Camera2D
export var panSpeed = 320.0
export var scrollSpeed = 5
var panBorderThickness = 40.0

# Used to indicate the bounds of the map (for restricted cam movement)
var panLimit = Vector2(-20,-20)
var maxZoom = 0.35

var mapWidth = 20 # just starting value
var mapHeight = 20 # just starting value

var m_position

var edgeScrollEnabled = false

# Handles scrolling:d
# -1 = zoom out
# 0 = neutral
# 1 = zooms in
var m_scrolling = 0

func _ready():
	set_process(true)
	var tiles = get_node("/root/n2_world/n2_tiles")
	mapWidth = tiles.GetMapWidth()
	mapHeight = tiles.GetMapHeight()
	
	self.zoom.x = 1.5
	self.zoom.y = 1.5
	
	
func _process(delta):
	camMove(delta)

func _input(e):
	if e is InputEventMouseMotion:
		m_position = e.position
		
	if e is InputEventMouseButton:
		if e.button_index == BUTTON_WHEEL_UP:
			m_scrolling = 1
		elif e.button_index == BUTTON_WHEEL_DOWN:
			m_scrolling = -1


#Responsible for the camera movement
func camMove(delta):
	if m_position != null:
		if Input.is_action_pressed("cam_up") || (m_position.y <= panBorderThickness && edgeScrollEnabled):
			self.position.y -= panSpeed * delta * (1 + self.zoom.y)
			
		if Input.is_action_pressed("cam_right") || (m_position.x >= get_viewport().size.x - panBorderThickness && edgeScrollEnabled):
			self.position.x += panSpeed * delta * (1 + self.zoom.x)
			
		if Input.is_action_pressed("cam_down")  || (m_position.y >= get_viewport().size.y - panBorderThickness && edgeScrollEnabled):
			self.position.y += panSpeed * delta * (1 + self.zoom.y)
			
		if Input.is_action_pressed("cam_left") || (m_position.x <= panBorderThickness && edgeScrollEnabled):
			self.position.x -= panSpeed * delta * (1 + self.zoom.x)
		
		if m_scrolling != 0:
			self.zoom.x -= scrollSpeed * delta * m_scrolling
			if (self.zoom.x < maxZoom):
				self.zoom.x = maxZoom
			self.zoom.y -= scrollSpeed * delta * m_scrolling
			if (self.zoom.y < maxZoom):
				self.zoom.y = maxZoom
			m_scrolling = 0
			
		self.position.x = clamp(self.position.x, 0, mapWidth)
		self.position.y = clamp(self.position.y, 0, mapHeight)