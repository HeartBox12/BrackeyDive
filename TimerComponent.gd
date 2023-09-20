extends TextureProgressBar

var inHaz = false
var basePos:Vector2 #for the shaking effect
@export var shakeSeverity:float #shake Severity

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	basePos = position

func _process(delta):
	value = $Timer.time_left
	if ($Timer.time_left < ($Timer.wait_time / 2)): #If the timer is halfway done, send a warning.
		inHaz = true
		get_parent().get_parent().eval_warn() #Send warning
	
	if inHaz:
		position = basePos + (shakeSeverity * Vector2(1, 0).rotated(randf_range(0, 2 * PI))) #shake

func _on_timer_timeout():
	Singleton.death.emit()
