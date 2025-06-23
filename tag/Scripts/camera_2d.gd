extends Camera2D

@export var move_speed = 0.5  # camera position lerp speed
@export var zoom_speed = 0.5  # camera zoom lerp speed
@export var min_zoom = 1.05  # closest you can zoom in
@export var max_zoom = 3  # furthest you can zoom out

@export var margin = Vector2(200, 75)  # include some buffer area around targets

@export var targets: Array[Node2D] = []

@onready var screen_size = get_viewport_rect().size

func _process(_delta):
	if !targets:
		return
	#
	#
	
	screen_size = get_viewport_rect().size  # ✅ Update only, don't redeclare

	# Camera center
	var p = Vector2.ZERO
	for target in targets:
		p += target.position
	p /= targets.size()
	position = lerp(position, p, move_speed)

	# Correct bounding rect
	var r = Rect2(targets[0].position, Vector2.ZERO)
	for i in range(1, targets.size()):
		r = r.expand(targets[i].position)
	r = r.grow_individual(margin.x, margin.y, margin.x, margin.y)

	var z
	if r.size.x > r.size.y * screen_size.aspect():
		z = r.size.x / screen_size.x
	else:
		z = r.size.y / screen_size.y

	# Invert zoom because increasing zoom value in Godot zooms IN
	var target_zoom = 1.0 / z
	target_zoom = clamp(target_zoom, min_zoom, max_zoom)
	zoom = lerp(zoom, Vector2.ONE * target_zoom, zoom_speed)

func add_target(t):
	if not t in targets:
		targets.append(t)

func remove_target(t):
	if t in targets:
		targets.erase(t)
