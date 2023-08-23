extends CharacterBody2D


const THRUST = 2
var input:Vector2 = Vector2(0, 0)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(_delta):
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
	
	velocity -= Vector2.UP * 0.5
	velocity += input * THRUST
	move_and_slide()
	
	#ADD SOME FORM OF CONFOUNDING MOVEMENT
