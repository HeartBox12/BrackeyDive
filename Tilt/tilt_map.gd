extends Node2D

var tilt:float = 0 #The actual angle
var tiltVel:float = 0 #The angle's rate of motion

@export var inputMagnitude:int
@export var bumpMagnitude:int
@export var playerTiltFactor:float #Inverse severity of player tilt
@export var indTiltFactor:float #inverse severity of indicator tilt
@export var fricMagnitude = 1.0

var inHaz = false #hazard, not haz cheeseburger.
var tiltThresh = 600 #The amount of tilt that is hazardous.
var tiltMax = 1200 #The maximum amount of tilt

var paused = false

func _process(delta): #Determine and apply input to tiltVel
	
	if paused: return
	
	if (Input.is_action_pressed("tilt_left")):
		tiltVel -= inputMagnitude * delta
	if (Input.is_action_pressed("tilt_right")):
		tiltVel += inputMagnitude * delta
	
	tiltVel -= (tiltVel * delta * fricMagnitude)
	
	tilt += tiltVel * delta
	
	if tilt > tiltMax:
		tilt = tiltMax
		tiltVel = 0
	
	if tilt < -tiltMax:
		tilt = -tiltMax
		tiltVel = 0
	
	$TiltPlayer.rotation = -(deg_to_rad(tilt * playerTiltFactor) * delta) #inverted so it looks better
	$TiltInd.position.x = $TiltIndDefault.position.x + tilt * indTiltFactor * delta
	
	#Determine if the player is outside safety zone
	if (!inHaz && abs(tilt) > tiltThresh):
		$HazBar.visible = true
		$HazTimer.start()
		inHaz = true
		Audio.get_node("Middle").volume_db = 0
	
	#If they are, do things.
	if inHaz:
		#Measure and display level of hazard. Max frame is 8 and min is zero.
		$HazBar.frame = int(($HazTimer.wait_time - $HazTimer.time_left) * 8 / 3) #CHANGE DIVISOR IF WAIT TIME IS CHANGED
		
		#Eval if player is back in safety zone
		if (abs(tilt) < tiltThresh):
			Audio.get_node("Middle").volume_db = -60
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
