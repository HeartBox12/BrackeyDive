extends Node2D

@export var navFile:PackedScene
@export var tiltFile:PackedScene
@export var clickFile:PackedScene

@export var navMapPos:Vector2
@export var tiltMapPos:Vector2
@export var clickMapPos:Vector2

var dieCallable = Callable(self, "die") #I should rethink some of these names.
var winCallable = Callable(self, "win")

var won = false
var lost = false

func _ready():
	Singleton.win.connect(winCallable)
	Singleton.death.connect(dieCallable)
	
	$AnimationPlayer.play("opening")

func die(): #Start of death sequence
	if !won:
		lost = true
		$AnimationPlayer.play("death")

func _close():
	Audio.get_node("Left").volume_db = -60
	Audio.get_node("Middle").volume_db = -60
	Audio.get_node("Right").volume_db = -60
	get_tree().change_scene_to_packed(load("res://Menu/menu.tscn")) #boot to menu

func win():
	if !lost:
		won = true
		$AnimationPlayer.play("win")
