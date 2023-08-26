extends Node2D

var inHaz = false
var overSpeed = false
@export var speedLimit:float
@export var warnSpeed:float

var paused = true

func _process(_delta):
	if paused: return
	
	#Determine if the player is outside safety zone
	if (!overSpeed && $NavPlayer.velocity.length() > warnSpeed): #add warning
		$TESTSpeedWarn.visible = true
		overSpeed = true
		FMODStudioModule.get_studio_system().set_parameter_by_name("Nav Music", 1, false)
	
	#If they are, do things.
	if overSpeed:
		#Measure and display level of hazard. Max frame is 62 and min is zero.
		if ($NavPlayer.velocity.length() > speedLimit):
			Singleton.death.emit() #death
		
		#Eval if player is back in safety zone
		if ($NavPlayer.velocity.length() < warnSpeed):
			$TESTSpeedWarn.visible = false
			overSpeed = false
			if !inHaz:
				FMODStudioModule.get_studio_system().set_parameter_by_name("Nav Music", 0, false)


func _on_warn_zone_entered(body, shape, index, local): #The player is nearing either edge.
	inHaz = true
	FMODStudioModule.get_studio_system().set_parameter_by_name("Nav Music", 1, false)

func _on_warn_zone_exited(body, shape, index, local):
	inHaz = false
	if !overSpeed:
		FMODStudioModule.get_studio_system().set_parameter_by_name("Nav Music", 0, false)

func _on_death_zone_entered(body, shape, index, local): #The player has left the map and died.
	Singleton.death.emit()

func _on_goal(body_rid, body, body_shape_index, local_shape_index):
	Singleton.win.emit()
	
func begin():
	visible = true
	$NavPlayer.paused = false
	$NavPlayer/bumpTimer.start()
