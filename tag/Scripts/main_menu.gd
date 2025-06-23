extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options_menu: Panel = $OptionsMenu
@onready var audio_control_slider: HSlider = $"OptionsMenu/VBoxContainer/Music/Audio Control Slider"
@onready var sfx_control_slider: HSlider = $"OptionsMenu/VBoxContainer/SFX/SFX Control Slider"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_buttons.visible = true
	options_menu.visible = false
	audio_control_slider.value = Global.music_volume_level
	sfx_control_slider.value = Global.sfx_volume_level
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _on_start_pressed() -> void:
	Global.reset()
	GameManager.reset()
	get_tree().change_scene_to_file("res://Scenes/number_of_players.tscn")

func _on_options_pressed() -> void:
	main_buttons.visible = false
	options_menu.visible = true

func _on_exit_pressed() -> void:
	get_tree().quit()
	
func _on_back_pressed() -> void:
	_ready()
