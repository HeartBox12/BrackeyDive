extends Node2D

@export var navFile:PackedScene
@export var tiltFile:PackedScene
@export var clickFile:PackedScene

@export var navMapPos:Vector2
@export var tiltMapPos:Vector2
@export var clickMapPos:Vector2

var dieCallable = Callable(self, "die") #I should rethink some of these names.
var winCallable = Callable(self, "win")

func _ready():
	Singleton.win.connect(winCallable)
	Singleton.death.connect(dieCallable)
	
	$AnimationPlayer.play("opening")

func die(): #Start of death sequence
	$AnimationPlayer.play("death")

func _close():
	Singleton.FMODInstance.release()
	get_tree().quit() #close the game.

func win():
	$AnimationPlayer.play("win")
