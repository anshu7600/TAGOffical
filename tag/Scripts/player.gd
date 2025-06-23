extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $HealthBar
@onready var win_screen_scene = preload("res://Scenes/win_screen.tscn")
@export var player_index: int = 1
const SPEED = 115
const JUMP_VELOCITY = -315


func _ready() -> void:
	load_player_frames()
	health_bar.set_color_of_bar(player_index)
	health_bar.init_health(Global.playerHealth[player_index-1])

func load_player_frames():
	var frames_path = "res://Scenes/player_%d_frames.tres" % player_index
	var frames = load(frames_path)
	if frames:
		sprite.frames = frames
	else:
		push_warning("Missing sprite frames for player %d" % player_index)

var is_hurt = false
var hurt_timer = 0.0
const HURT_DURATION = 0.5  # seconds

var is_rolling = false
var roll_timer = 0.0
const ROLL_DURATION = 0.6
const ROLL_SPEED = 100

func _physics_process(delta: float) -> void:
	if not is_inside_tree() or !Global.timer_started:
		return
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Quit shortcut
	if Input.is_action_just_pressed("quit"):
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

	# Handle states
	if is_hurt:
		hurt_timer -= delta
		if hurt_timer <= 0:
			is_hurt = false
		return  # Skip other actions

	if is_rolling:
		roll_timer -= delta
		if roll_timer <= 0:
			is_rolling = false
		else:
			sprite.play("Roll")
			var dir = -1 if sprite.flip_h else 1
			velocity.x = dir * ROLL_SPEED
			move_and_slide()
			return  # Skip rest of input

	# Input
	var jump = "jump%d" % player_index
	var roll = "roll%d" % player_index
	var move_left = "move_left%d" % player_index
	var move_right = "move_right%d" % player_index
	var direction := Input.get_axis(move_left, move_right)

	# Jump
	if Input.is_action_just_pressed(jump) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sprite.play("Jump")

	# Roll
	if Input.is_action_just_pressed(roll) and is_on_floor():
		is_rolling = true
		roll_timer = ROLL_DURATION
		sprite.play("Roll")
		return  # Start roll next frame

	# Movement + Animation
	if is_on_floor():
		if direction == 0:
			sprite.play("Idle")
		else:
			sprite.play("Run")

	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func play_hurt():
	is_hurt = true
	hurt_timer = HURT_DURATION
	sprite.play("Hurt")
	var prev_health = Global.playerHealth[player_index-1]
	Global.playerHealth[player_index-1] = prev_health - Global.HEALTH_DEDUCTED
	var current_health = Global.playerHealth[player_index-1]
	if current_health == 0:
		animation_player.play("killed")
		GameManager.camera_2d.remove_target(GameManager.playerReference[player_index-1])
	health_bar._set_health(current_health)
	check_players()
	
func check_players():
	var players = 0
	var possible_winner_index = 0
	for i in range(GameManager.number_of_players):
		if (Global.playerHealth[i] != 0):
			players += 1
			possible_winner_index = i
	if players == 1:
		var win_screen = win_screen_scene.instantiate()
		get_tree().current_scene.add_child(win_screen)  # Add to current scene
		win_screen.set_title_winner(possible_winner_index + 1)
		get_tree().paused = true
		
		
func _on_contact_area_body_entered(body: Node) -> void:
	if body == self:
		return
	#print(">>> [FRAME %s] Player %d triggered by Player %d" %
	#	[str(Engine.get_physics_frames()), player_index, body.player_index])
	if body is CharacterBody2D:
		var other_index: int = body.player_index
		print("Player %d entered Player %d" % [other_index, player_index])
