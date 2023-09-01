extends Node2D

var markArray = []
var windowArray = [null, null, null]

@export var windowScene:PackedScene

var completeCallable = Callable(self, "_resolve_complete")

# Called when the node enters the scene tree for the first time.
func _ready():
	markArray = [$Marker0, $Marker1, $Marker2]


func _process(_delta):
	pass

func _on_spawn_timeout():
	# Spawn
	var instance = windowScene.instantiate()
	add_child(instance)
	
	#connect Window completion signal ("complete(index)") to func resolve_complete(index).
	instance.connect("complete", completeCallable)
	
	#Find the first open slot in openSlots[] and then get position from markArray[]. Or get rando.
	for i in 3:
		if windowArray[i] == null: #Slot in index i is free
			#Set the instance up in that slot and reserve it
			instance.index = i
			instance.position = markArray[i].position
			windowArray[i] = instance
			break
	
	#reset the spawn timer
	$spawnTime.start()

func _resolve_complete(index):
	windowArray[index] = null
	eval_warn() #check and see if that was the last one in haz.
	#mark slot as open

func eval_warn(): #Play or stop the warning track for the Click map. Includes decision structure.
	for i in 3:
		if windowArray[i] != null && windowArray[i].get_node("TimerComponent").inHaz == true:
			Audio.get_node("Right").volume_db = 0
			return #Found 1 in haz, exit function.
	Audio.get_node("Right").volume_db = -60
	#found none in haz.

func begin():
	$spawnTime.start()
	visible = true
