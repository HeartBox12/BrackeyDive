extends Node2D

var inHaz = false
@export var speedLimit:float

func _process(_delta):
	#Determine if the player is outside safety zone
	if (!inHaz && $NavPlayer.velocity.length() > speedLimit):
		$HazBar.visible = true
		$HazTimer.start()
		inHaz = true
	
	#If they are, do things.
	if inHaz:
		#Measure and display level of hazard. Max frame is 62 and min is zero.
		$HazBar.frame = int($HazTimer.time_left * 62 / 3) #CHANGE DIVISOR IF WAIT TIME IS CHANGED
		
		#Eval if player is back in safety zone
		if ($NavPlayer.velocity.length() < speedLimit):
			$HazBar.visible = false
			inHaz = false
			$HazTimer.stop()


func _on_warn_zone_entered(body, shape, index, local): #The player is nearing either edge.
	pass

func _on_warn_zone_exited(body, shape, index, local):
	pass # Replace with function body.

func _on_death_zone_entered(body, shape, index, local): #The player has left the map and died.
	Singleton.death.emit()
