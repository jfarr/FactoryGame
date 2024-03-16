extends Node2D

var draggable = false
var initial_pos : Vector2
var offset : Vector2
var mined = {}
@onready var inventory = get_tree().current_scene.player_inventory
@onready var world = get_tree().current_scene

func _ready():
	deselect()

func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			initial_pos = global_position
			offset = get_global_mouse_position() - global_position
			global.is_dragging = true 
			select()
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			global.is_dragging = false
			deselect()
			if !world.is_terrain_clicked(world.ground):
				var tween = get_tree().create_tween()
				tween.tween_property(self, "position", initial_pos, 0.1).set_ease(Tween.EASE_OUT)
				return
			if not Input.is_action_pressed("no_snap"):
				var snapped = Vector2(int(global_position.x) / 40 * 40 + 20, int(global_position.y) / 40 * 40 + 20)
				var tween = get_tree().create_tween()
				tween.tween_property(self, "position", snapped, 0.1).set_ease(Tween.EASE_OUT)

func select():
	$CollectionArea/Sprite2D.visible = true

func deselect():
	$CollectionArea/Sprite2D.visible = false

func collect_resources():
	for node in mined:
		var item : InventoryItem = node.item
		print("mining %s" % item)
		inventory.insert(item, item.collection_rate)

func _on_clickable_area_mouse_entered():
	if not global.is_dragging:
		draggable = true

func _on_clickable_area_mouse_exited():
	if not global.is_dragging:
		draggable = false

func _on_collection_area_body_entered(body):
	if body.is_in_group("mineral"):
		mined[body] = 1
		print("add minable")
		print(mined)

func _on_collection_area_body_exited(body):
	if body.is_in_group("mineral"):
		mined.erase(body)
		print("remove minable")
		print(mined)

func _on_collection_timer_timeout():
	collect_resources()
