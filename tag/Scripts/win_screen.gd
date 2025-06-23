extends CanvasLayer

@onready var label: Label = $Panel/Label
@onready var winner_image: TextureRect = $Panel/WinnerImage

func _ready() -> void:
	pass
	
func set_title_winner(player_index: int):
	Global.timer_started = false
	label.text = "Player %d WON!" % player_index
	label.add_theme_color_override("font_color", Global.playerColor[player_index-1])
	var frames_path = "res://Scenes/player_%d_frames.tres" % player_index
	var frames: SpriteFrames = load(frames_path)
	
	if frames:
		var tex = frames.get_frame_texture("Idle", 0)
		winner_image.texture = tex
	else:
		push_warning("Missing winner sprite for player %d" % player_index)


func _on_to_main_menu_pressed() -> void:
	get_tree().paused = false
	Global.reset()
	GameManager.reset()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_retry_pressed() -> void:
	get_tree().paused = false
	Global.reset() 
	get_tree().reload_current_scene()
