extends Node2D

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton and event.pressed and !event.double_click and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		print("shoreline: %s" % shoreline_clicked())
		print("rocks: %s" % rocks_clicked())

func shoreline_clicked():
	var tile_map = $Ground
	var clicked_cell = tile_map.local_to_map(tile_map.get_local_mouse_position())
	var data = tile_map.get_cell_tile_data(1, clicked_cell)
	if data:
		return data.get_custom_data("shoreline")
	else:
		return false

func rocks_clicked():
	var tile_map = $Rocks
	var clicked_cell = tile_map.local_to_map(tile_map.get_local_mouse_position())
	var data = tile_map.get_cell_tile_data(0, clicked_cell)
	return data.get_custom_data("mineral") if data else null
