class_name Machine extends StaticBody2D

@export var sprite : Sprite2D
@export var clickable_area : Area2D

var creating = false
var draggable = false
var droppable = false
var initial_pos : Vector2
var offset : Vector2
var overlapping = 0
var initial_scale : Vector2

@onready var world = get_tree().current_scene

func _ready():
	assert(sprite)
	assert(clickable_area)
	clickable_area.mouse_entered.connect(_on_clickable_area_mouse_entered)
	clickable_area.mouse_exited.connect(_on_clickable_area_mouse_exited)
	clickable_area.body_entered.connect(_on_clickable_area_body_entered)
	clickable_area.body_exited.connect(_on_clickable_area_body_exited)
	initial_scale = sprite.scale

func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			start_dragging()
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			if not droppable or not world.is_terrain_clicked(world.ground):
				cancel_drag()
				#var tween = get_tree().create_tween()
				#tween.tween_property(self, "position", initial_pos, 0.1).set_ease(Tween.EASE_OUT)
				#modulate = Color(1, 1, 1, 1)
				#z_index -= 1
				#if creating:
					#queue_free()
				#return
			else:
				finish_dragging()
			#if not Input.is_action_pressed("no_snap"):
				#var snapped = Vector2(int(global_position.x) / 40 * 40 + 20, int(global_position.y) / 40 * 40 + 20)
				#var tween = get_tree().create_tween()
				#tween.tween_property(self, "position", snapped, 0.1).set_ease(Tween.EASE_OUT)
				#z_index -= 1
				#print("dropped at %s" % snapped)
			#if creating:
				#creating = false
				#sprite.self_modulate = Color(1, 1, 1, 1)

func start_creating():
	sprite.self_modulate = Color(0, 1, 0, 1)
	creating = true
	draggable = true
	start_dragging()

func start_dragging():
	if not global.is_dragging:
		#print("got here")
		initial_pos = global_position
		offset = get_global_mouse_position() - global_position
		global.is_dragging = true 
		droppable = true
		overlapping = 0
		z_index += 1

func cancel_drag():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", initial_pos, 0.1).set_ease(Tween.EASE_OUT)
	modulate = Color(1, 1, 1, 1)
	z_index -= 1
	if creating:
		queue_free()

func finish_dragging():
	if not Input.is_action_pressed("no_snap"):
		var snapped = Vector2(int(global_position.x) / 40 * 40 + 20, int(global_position.y) / 40 * 40 + 20)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", snapped, 0.1).set_ease(Tween.EASE_OUT)
		z_index -= 1
		print("dropped at %s" % snapped)
	if creating:
		creating = false
		sprite.self_modulate = Color(1, 1, 1, 1)

func _on_clickable_area_mouse_entered():
	if not global.is_dragging:
		sprite.scale *= Vector2(1.1, 1.1)
		draggable = true

func _on_clickable_area_mouse_exited():
	sprite.scale = initial_scale
	if not global.is_dragging:
		draggable = false

func _on_clickable_area_body_entered(body):
	if global.is_dragging and body != self:
		overlapping += 1
		droppable = false
		modulate = Color(1, 0, 0, 0.5)

func _on_clickable_area_body_exited(body):
	if global.is_dragging and body != self:
		overlapping -= 1
		if overlapping < 1:
			droppable = true
			modulate = Color(1, 1, 1, 1)

