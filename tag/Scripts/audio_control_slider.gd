extends HSlider

@export var audio_bus_name: String

var audio_bus_id

func _ready():
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)

func _on_value_changed(value1: float) -> void:
	if audio_bus_name == "Music":
		Global.music_volume_level = value1
	else:
		Global.sfx_volume_level = value1

	AudioServer.set_bus_volume_db(audio_bus_id, linear_to_db(value1))
