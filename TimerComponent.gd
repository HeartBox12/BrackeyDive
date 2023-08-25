extends TextureProgressBar

var inHaz = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = $Timer.time_left
	if ($Timer.time_left < ($Timer.wait_time / 2)): #If the timer is halfway done, send a warning.
		inHaz = true
		get_parent().get_parent().eval_warn() #Send warning

func _on_timer_timeout():
	Singleton.death.emit()
