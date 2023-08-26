extends Node2D

var tilt:float = 0 #The actual angle
var tiltVel:float = 0 #The angle's rate of motion

@export var bumpMagnitude:int
@export var playerTiltFactor:float #Inverse severity of player tilt
@export var indTiltFactor:float #inverse severity of indicator tilt
@export var parallax:int

var inHaz = false #hazard, not haz cheeseburger.
var tiltThresh = 200 #The amount of tilt that is hazardous.

var paused = true

func _process(delta): #Determine and apply input to tiltVel
	$ParallaxBackground.offset.y += parallax * delta
	
	if paused: return
	
	if (Input.is_action_pressed("tilt_left")):
		tiltVel -= 1
	if (Input.is_action_pressed("tilt_right")):
		tiltVel += 1
	
	tilt += tiltVel
	
	$TiltPlayer.rotation = -(deg_to_rad(tilt * playerTiltFactor) * delta) #inverted so it looks better
	$TiltInd.position.x = $TiltIndDefault.position.x + tilt * indTiltFactor * delta
	
	#Determine if the player is outside safety zone
	if (!inHaz && abs(tilt) > tiltThresh):
		$HazBar.visible = true
		$HazTimer.start()
		inHaz = true
	
	#If they are, do things.
	if inHaz:
		FMODStudioModule.get_studio_system().set_parameter_by_name("Tilt Music", 1, false)
		#Measure and display level of hazard. Max frame is 62 and min is zero.
		$HazBar.frame = int($HazTimer.time_left * 62 / 3) #CHANGE DIVISOR IF WAIT TIME IS CHANGED
		
		#Eval if player is back in safety zone
		if (abs(tilt) < tiltThresh):
			FMODStudioModule.get_studio_system().set_parameter_by_name("Tilt Music", 0, false)
			$HazBar.visible = false
			inHaz = false
			$HazTimer.stop()

func _timed_bump(): #bump the tilt
	if (randi_range(0, 1) == 1):
		tiltVel -= bumpMagnitude
	else:
		tiltVel += bumpMagnitude


func _on_haz_timer_timeout():
	Singleton.death.emit()

func begin():
	visible = true
	$bumpBuffer.start()
	paused = false
