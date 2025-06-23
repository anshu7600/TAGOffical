extends Node2D

const SPEED = 120
var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_right_ground: RayCast2D = $RayCastRightGround
@onready var ray_cast_left_ground: RayCast2D = $RayCastLeftGround

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding() || !ray_cast_right_ground.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding() || !ray_cast_left_ground.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	# Engine.time_scale = .5
	position.x += SPEED * delta * direction;
