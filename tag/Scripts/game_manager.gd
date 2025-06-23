extends Node

var score = 0
var camera_2d: Camera2D = null
@export var playerReference =  []
@export var number_of_players: int = 1
@export var player_scene: PackedScene = preload("res://Scenes/Player.tscn")
var rng = RandomNumberGenerator.new()
var tagger_index 
func loadPlayers(number_of_players_new):
	tagger_index = rng.randi_range(0, number_of_players-1)
	print("Tagger is %d" % tagger_index)
	playerReference.clear()
	for i in range(number_of_players_new):
		var player_instance = player_scene.instantiate()
		player_instance.player_index = i + 1
		player_instance.name = "Player%d" % (i + 1)
		
		var arrow = player_instance.get_node("Arrow")
		arrow.frame = i
		print("I: %d and TaggerNumber: %d" % [i, tagger_index])
		print(i == tagger_index)
		arrow.visible = i == tagger_index
		
		get_tree().current_scene.call_deferred("add_child", player_instance)
		playerReference.append(player_instance)
		
		if camera_2d:
			camera_2d.add_target(player_instance)
		else:
			push_warning("camera_2d is null!")

		player_instance.position = Vector2((i - 0.9) * 20, -20)

func assign_tagger(index_to_assign):
	var player = playerReference[index_to_assign]
	player.get_node("Arrow").visible = true
	tagger_index = index_to_assign

func remove_current_tagger():
	var player = playerReference[tagger_index]
	player.get_node("Arrow").visible = false

	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func add_point():
	score += 1
	
func reset():
	camera_2d = null
	playerReference =  []
	number_of_players = 1
	player_scene = preload("res://Scenes/Player.tscn")
