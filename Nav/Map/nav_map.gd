extends Node2D

var inHaz = false
var overSpeed = false
@export var speedLimit:float
@export var warnSpeed:float

var paused = true

@export var shakeSeverity:int
@export var speedometerShakeSeverity:int
var basePos
var speedometerBasePos

func _ready():
	basePos = position
	speedometerBasePos = $speedometer.position

func _process(_delta):
	if paused: return
	
	$speedometer/needle.rotation_degrees = ($NavPlayer.velocity.y / speedLimit) * 240
	
	#Determine if the player is outside safety zone
	if (!overSpeed && $NavPlayer.velocity.y > warnSpeed): #add warning
		overSpeed = true
		Audio.get_node("Left").volume_db = 0
	
	#If they are, do things.
	if overSpeed:
		$speedometer.position = speedometerBasePos + (speedometerShakeSeverity * Vector2(1, 0).rotated(randf_range(0, 2 * PI))) #shake
		#Measure and display level of hazard. Max frame is 62 and min is zero.
		if ($NavPlayer.velocity.y > speedLimit):
			Singleton.death.emit() #death`s
		
		#Eval if player is back in safety zone
		if ($NavPlayer.velocity.y < warnSpeed):
			overSpeed = false
			$speedometer.position = speedometerBasePos
			if !inHaz:
				Audio.get_node("Left").volume_db = -60
	
	if inHaz:
		position = basePos + (shakeSeverity * Vector2(1, 0).rotated(randf_range(0, 2 * PI))) #shake


func _on_warn_zone_entered(body, shape, index, local): #The player is nearing either edge.
	inHaz = true
	Audio.get_node("Left").volume_db = 0

func _on_warn_zone_exited(body, shape, index, local):
	inHaz = false
	position = basePos
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
