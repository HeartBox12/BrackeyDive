extends CharacterBody2D


const THRUST = 50
var input:Vector2 = Vector2(0, 0)
@export var bumpSeverity:int
@export var friction = .75

var paused = true #set to false when this minigame begins

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 15


func _physics_process(delta):
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
	
	velocity += (Vector2(0, gravity) * delta)
	velocity += input * THRUST * delta
	velocity -= (velocity * delta * friction) #friction
	move_and_slide()


func _bump(): #called on a loop by a timer
	if (randi_range(0, 1) == 1): #50/50 chance
		velocity.x += bumpSeverity
	else:
		velocity.x -= bumpSeverity
