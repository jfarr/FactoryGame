extends Node2D

var draggable = false
var offset : Vector2

func _ready():
	deselect()

func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			offset = get_global_mouse_position() - global_position
			global.is_dragging = true 
			select()
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			deselect()
			print("dropping at %s" % global_position)
			if not Input.is_action_pressed("no_snap"):
				var snapped = Vector2(int(global_position.x) / 40 * 40 + 20, int(global_position.y) / 40 * 40 + 20)
				print("snapped: %s" % snapped)
				print("delta: %s" % (snapped - global_position))
				var tween = get_tree().create_tween()
				tween.tween_property(self, "position", snapped, 0.1).set_ease(Tween.EASE_OUT)

func select():
	$CollectionArea/Sprite2D.visible = true

func deselect():
	$CollectionArea/Sprite2D.visible = false

func _on_clickable_area_mouse_entered():
	if not global.is_dragging:
		draggable = true
		#scale = Vector2(1.05, 1.05)

func _on_clickable_area_mouse_exited():
	if not global.is_dragging:
		draggable = false
		#scale = Vector2(1.0,1.0)
