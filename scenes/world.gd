extends Node2D

enum {
	ground = 0,
	water = 1,
	shoreline = 2,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed and !event.double_click and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		print("ground: %s" % is_terrain_clicked(ground))
		print("water: %s" % is_terrain_clicked(water))
		print("shoreline: %s" % is_terrain_clicked(shoreline))
		
func is_terrain_clicked(terrain):
	var tile_map = $Ground
	var clicked_cell = tile_map.local_to_map(tile_map.get_local_mouse_position())
	return tile_map.get_cell_source_id(terrain, clicked_cell) != -1
