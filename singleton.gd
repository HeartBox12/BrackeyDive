extends Node

signal death #Emit this from wherever, whenever. It's pretty neat.
signal win
var volume_db #to be stored and called between scenes

func _unhandled_input(event):
	if event.is_action_pressed("close game"):
		get_tree().quit()
