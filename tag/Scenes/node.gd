extends Node

var did_spawn_players := false
@onready var timer_countdown: Panel = $"../CanvasLayer/TimerCountdown"
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	timer_countdown.reset()
	Global.timer_started = false
	if not did_spawn_players:
		GameManager.camera_2d = $"../Camera2D"
		GameManager.loadPlayers(GameManager.number_of_players)
		did_spawn_players = true
	
	animation_player.play("countdown321")
	timer.start()
func _on_timer_timeout() -> void:
	timer_countdown.start_time()
