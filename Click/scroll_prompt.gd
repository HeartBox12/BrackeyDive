extends TextureRect

signal complete(index)
var index = 0

var goalMin #Cursor must be above this value for 1 second
var goalMax #Cursor must be below this value for 1 second.

var scrollSpeed

@export var barMax:int #The maximum value of the bar. Used for calculations
#since the cursor will start on one side of the bar, the zone can't be at 0.
@export var barMin:int
@export var goalSize:int #Should match the pixel width 

func _ready():
	pass
	
	#Generate goalMin's position as between barMin and barMax = goalSize
	#Set goalMax relative to it
	#Position the zone sprite
	

func _unhandled_input(event):
	if event.is_action_pressed("click_scroll_up"):
		pass
		#Reposition cursor based on scrollSpeed
	
	if event.is_action_pressed("click_scroll_down"):
		pass
		#Reposition cursor based on scrollSpeed
	
	#May as well call this here, since only this is when this can happen
	if $cursor.position < goalMax && $cursor.position > goalMin:
		pass
		#start the goal timer
		#somehow make a visual indication
	else:
		pass
		#Stop the timer (even if it isn't running).
		#cancel the visual indication

func satisfied(): #Call when the mini-minigame is complete.
	complete.emit(index)
	queue_free()
