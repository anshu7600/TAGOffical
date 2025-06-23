extends Panel

@onready var minutes: Label = $Label
@onready var seconds: Label = $Label2
@onready var timer: Timer = $Timer
@onready var middle: Label = $Middle
@onready var win_screen_scene = preload("res://Scenes/win_screen.tscn")
var minute
var sec
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func reset():
	minutes.text = "00"
	seconds.text = "00"
	minutes.add_theme_color_override("font_color", "#d1ffcd")
	seconds.add_theme_color_override("font_color", "#d1ffcd")
	middle.add_theme_color_override("font_color", "#d1ffcd")

func start_time():
	Global.timer_started = true
	timer.wait_time = Global.selected_timer_value
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Global.timer_started == false: return
	var minutes_and_seconds = time_left()
	if (minutes_and_seconds[0] == 0 && minutes_and_seconds[1] == 0):
		var win_screen = win_screen_scene.instantiate()
		get_tree().current_scene.add_child(win_screen)  # Add to current scene
		win_screen.set_title_loser(GameManager.tagger_index + 1)
		get_tree().paused = true
		return
	if (minutes_and_seconds[0] == 0 && minutes_and_seconds[1] <= 15):
		minutes.add_theme_color_override("font_color", "red")
		seconds.add_theme_color_override("font_color", "red")
		middle.add_theme_color_override("font_color", "red")
	minutes.text = "%02d" % minutes_and_seconds[0]
	seconds.text = "%02d" % minutes_and_seconds[1]
	
func time_left():
	var current_time_left = timer.time_left
	minute = floor(current_time_left/60)
	sec = int(current_time_left) % 60
	return [minute, sec]
