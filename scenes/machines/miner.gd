extends StaticBody2D

var creating = false
var draggable = false
var droppable = false
var initial_pos : Vector2
var offset : Vector2
var mined = {}
var to_mine = {}
var overlapping = 0

@onready var world = get_tree().current_scene

func _ready():
	deselect()

func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			start_dragging()
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			deselect()
			if not droppable or not world.is_terrain_clicked(world.ground):
				var tween = get_tree().create_tween()
				tween.tween_property(self, "position", initial_pos, 0.1).set_ease(Tween.EASE_OUT)
				modulate = Color(1, 1, 1, 1)
				if creating:
					queue_free()
				return
			if not Input.is_action_pressed("no_snap"):
				var snapped = Vector2(int(global_position.x) / 40 * 40 + 20, int(global_position.y) / 40 * 40 + 20)
				var tween = get_tree().create_tween()
				tween.tween_property(self, "position", snapped, 0.1).set_ease(Tween.EASE_OUT)
				print("dropped at %s" % snapped)
			mined = to_mine
			to_mine = {}
			if creating:
				creating = false
				$Sprite2D.self_modulate = Color(1, 1, 1, 1)

func start_creating():
	creating = true
	$Sprite2D.self_modulate = Color(0, 1, 0, 1)

func start_dragging():
	initial_pos = global_position
	offset = get_global_mouse_position() - global_position
	global.is_dragging = true 
	draggable = true
	droppable = true
	overlapping = 0
	to_mine = {}
	select()

func select():
	$Sprite2D.scale *= Vector2(1.1, 1.1)
	$CollectionArea.visible = true

func deselect():
	$Sprite2D.scale /= Vector2(1.1, 1.1)
	$CollectionArea.visible = false

func _on_clickable_area_mouse_entered():
	if not global.is_dragging:
		draggable = true

func _on_clickable_area_mouse_exited():
	if not global.is_dragging:
		draggable = false

func _on_collection_area_body_entered(body):
	if body.is_in_group("mineral"):
		to_mine[body] = 1
		#print("add minable")
		#print(to_mine)

func _on_collection_area_body_exited(body):
	if body.is_in_group("mineral"):
		to_mine.erase(body)
		#print("remove minable")
		#print(to_mine)

func _on_clickable_area_body_entered(body):
	if global.is_dragging and body != self:
		overlapping += 1
		print("overlapping: %s" % body)
		droppable = false
		modulate = Color(1, 0, 0, 0.5)

func _on_clickable_area_body_exited(body):
	if global.is_dragging and body != self:
		overlapping -= 1
		if overlapping < 1:
			droppable = true
			modulate = Color(1, 1, 1, 1)
