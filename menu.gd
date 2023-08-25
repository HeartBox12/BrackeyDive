extends Control

@export var dest:PackedScene
var bus:Bus

func _ready():
	bus = FMODStudioModule.get_studio_system().get_bus_by_id(FMODGuids.Busses.MASTER_BUS)

func _on_start_pressed():
	get_tree().change_scene_to_packed(dest)

func _on_volume_changed(value):
	bus.set_volume(value)
