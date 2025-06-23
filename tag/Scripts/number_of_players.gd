extends Control

@onready var panel: Panel = $TreeBG
@onready var game = preload("res://Scenes/Game.tscn")
@onready var finaltimer = preload("res://finaltimer.tscn")
@onready var dark_bg: Panel = $DarkBG
@onready var on_or_off: Label = $DarkBG/Panel/OnOrOff

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dark_bg.visible = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_3_players_pressed() -> void:
	GameManager.number_of_players = 3
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_2_players_pressed() -> void:
	GameManager.number_of_players = 2
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_4_players_pressed() -> void:
	GameManager.number_of_players = 4
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_game_settings_pressed() -> void:
	dark_bg.visible = true

func _on_close_pressed() -> void:
	dark_bg.visible = false

func _on_select_time_value_changed(value: float) -> void:
	Global.selected_timer_value = value	

func _on_buffs_choice_toggled(toggled_on: bool) -> void:
	if toggled_on:
		on_or_off.text = "ON"
	else:
		on_or_off.text = "OFF"
	Global.buffs = toggled_on
