extends CharacterBody2D


const THRUST = 2
var input:Vector2 = Vector2(0, 0)
@export var bumpSeverity:int
@export var friction:float

var paused = true #set to false when this minigame begins

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(_delta):
	if paused: return #Don't do anything until main says to
	#Determine input
	input = Vector2(0, 0)
	
	if (Input.is_action_pressed("nav_up")):
		input.y -= 1
	if (Input.is_action_pressed("nav_down")):
		input.y += 1
	if (Input.is_action_pressed("nav_left")):
		input.x -= 1
	if (Input.is_action_pressed("nav_right")):
		input.x += 1
	
	velocity += ProjectSettings.get_setting("physics/2d/default_gravity_vector") * 0.5
	velocity += input * THRUST
	velocity *= friction
	move_and_slide()


func _bump(): #called on a loop by a timer
	if (randi_range(0, 1) == 1): #50/50 chance
		velocity.x += bumpSeverity
	else:
		velocity.x -= bumpSeverity
