extends CanvasLayer

var ready = false
onready var FPS_val = get_node("MarginContainer/HBoxContainer/FPS/Rect/value")
onready var NODES_val = get_node("MarginContainer/HBoxContainer/NumNodes/Rect/value")
onready var TILES_val = get_node("MarginContainer/HBoxContainer/NumTiles/Rect/value")
onready var CLICKS_val = get_node("MarginContainer/HBoxContainer/NumClickables/Rect/value")
onready var EFFECTS_val = get_node("MarginContainer/HBoxContainer/NumEffects/Rect/value")
onready var PEEPS_val = get_node("MarginContainer/HBoxContainer/NumPeeps/Rect/value")


func _ready():
	ready = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (ready):
		FPS_val.text = str(Engine.get_frames_per_second())
		NODES_val.text = str(get_tree().get_nodes_in_group("Objects").size())
		TILES_val.text = str(get_tree().get_nodes_in_group("Tiles").size())
		CLICKS_val.text = str(get_tree().get_nodes_in_group("Clickables").size())
		EFFECTS_val.text = str(get_tree().get_nodes_in_group("Effects").size())
		PEEPS_val.text = str(get_tree().get_nodes_in_group("Peeps").size())
		
