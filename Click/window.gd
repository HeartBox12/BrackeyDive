extends TextureRect

signal complete(index)
var index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.position.x = randi_range(0, 416) #Positioned so the button is within the window.
	$Button.position.y = randi_range(0, 178)

func satisfied(): #Call when the mini-minigame is complete.
	complete.emit(index)
	queue_free()
