extends Node2D


var MaxTimer = 10
var timer = randi() % MaxTimer/2 + MaxTimer/2
var Created

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimatedSprite").connect("animation_finished", self, "on_finished")
	var scaleVal = rand_range(0.5, 2)
	set_scale(Vector2(scaleVal, scaleVal))
	Created = false



func _process(delta):
	timer -= 1
	if (timer <= 0 && Created == false):
		get_node("AnimatedSprite").set_frame(0)
		get_node("AnimatedSprite").play()
		get_node("AnimatedSprite").set_speed_scale(1)
		Created = true
		

func on_finished():
	self.queue_free()