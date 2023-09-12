extends Node2D

var inHaz = false
var overSpeed = false
@export var speedLimit:float
@export var warnSpeed:float

var paused = true

func _process(_delta):
	if paused: return
	
	$needle.rotation_degrees = ($NavPlayer.velocity.y / speedLimit) * 240
	
	#Determine if the player is outside safety zone
	if (!overSpeed && $NavPlayer.velocity.y > warnSpeed): #add warning
		overSpeed = true
		Audio.get_node("Left").volume_db = 0
	
	#If they are, do things.
	if overSpeed:
		#Measure and display level of hazard. Max frame is 62 and min is zero.
		if ($NavPlayer.velocity.y > speedLimit):
			Singleton.death.emit() #death`s
		
		#Eval if player is back in safety zone
		if ($NavPlayer.velocity.y < warnSpeed):
			overSpeed = false
			if !inHaz:
				Audio.get_node("Left").volume_db = -60


func _on_warn_zone_entered(body, shape, index, local): #The player is nearing either edge.
	inHaz = true
	Audio.get_node("Left").volume_db = 0

func _on_warn_zone_exited(body, shape, index, local):
	inHaz = false
	if !overSpeed:
		Audio.get_node("Left").volume_db = -60

func _on_death_zone_entered(body, shape, index, local): #The player has left the map and died.
	Singleton.death.emit()

func _on_goal(body_rid, body, body_shape_index, local_shape_index):
	Singleton.win.emit()
	
func begin():
	visible = true
	paused = false
	$NavPlayer.paused = false
	$NavPlayer/bumpTimer.start()
