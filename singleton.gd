extends Node

signal death #Emit this from wherever, whenever. It's pretty neat.
signal win
var FMODInstance

func _ready():
	FMODInstance = RuntimeManager.create_instance_id(FMODGuids.Events.MUSIC_MUSIC)
	FMODInstance.start() #MOVE

func _unhandled_input(event):
	if event.is_action_pressed("close game"):
		FMODInstance.release()
		get_tree().quit()
