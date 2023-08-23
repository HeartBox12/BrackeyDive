extends TextureProgressBar


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = $Timer.time_left

func _on_timer_timeout():
	Singleton.death.emit()
