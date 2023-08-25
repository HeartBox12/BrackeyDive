extends Node

signal death #Emit this from wherever, whenever. It's pretty neat.
signal win
var FMODInstance

func _ready():
	FMODInstance = FMODStudioModule.get_studio_system().get_event_by_id(FMODGuids.Events.MUSIC_MUSIC).create_instance()
	FMODInstance.start() #MOVE
