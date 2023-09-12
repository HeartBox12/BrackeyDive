extends AudioStreamPlayer


func _on_finished():
	play()

func _on_left_finished():
	$Left.play()

func _on_middle_finished():
	$Middle.play()

func _on_right_finished():
	$Right.play()
