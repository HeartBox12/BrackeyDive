extends Control

@export var dest:PackedScene

func _on_start_pressed():
	get_tree().change_scene_to_packed(dest)

func _on_volume_changed(value):
	Singleton.volume_db = linear_to_db($volSlider.value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db($volSlider.value))
