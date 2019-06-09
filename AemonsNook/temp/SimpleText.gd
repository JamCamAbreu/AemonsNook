extends Label

var timeSeconds = 0

func _on_Timer_timeout():
	timeSeconds += 1
	text = String(timeSeconds)
