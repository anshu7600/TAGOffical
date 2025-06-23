extends Node

func hit_stop_short():
	Engine.time_scale = 0
	await get_tree().create_timer(.15, true, false, true).timeout
	Engine.time_scale = 1

func slow_motion():
	Engine.time_scale = 0.5
	await get_tree().create_timer(1, true, false, true).timeout
	Engine.time_scale = 1
