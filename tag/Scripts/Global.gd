extends Node

var music_volume_level: float = .75  
var sfx_volume_level: float = .75
var timer_started: bool = false
var selected_timer_value: float = 60.0
var buffs: bool = false
const MAX_HEALTH: int = 100
var playerHealth := [MAX_HEALTH, MAX_HEALTH, MAX_HEALTH, MAX_HEALTH]
const HEALTH_DEDUCTED: int = 25 
const REDUCED_HEALTH_DEDUCTED: int = 20
const playerColor := ["#0080a2", "#d2202c", "#01721e", "#510bb4"]

func reset():
	playerHealth = [MAX_HEALTH, MAX_HEALTH, MAX_HEALTH, MAX_HEALTH]
	
	
