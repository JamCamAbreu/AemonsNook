extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Head").set_frame(randi() % get_node("Head").get_sprite_frames().get_frame_count("default"))

