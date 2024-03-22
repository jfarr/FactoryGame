extends Node2D

enum {
	ground = 0,
	water = 1,
	shoreline = 2,
}

@export var player_inventory : Inventory

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
#
#func _input(event):
	#if event is InputEventMouseButton and event.pressed and !event.double_click and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		#print("ground: %s" % is_terrain_clicked(ground))
		#print("water: %s" % is_terrain_clicked(water))
		#print("shoreline: %s" % is_terrain_clicked(shoreline))

func is_terrain_clicked(terrain):
	var tile_map = $Ground
	var clicked_cell = tile_map.local_to_map(tile_map.get_local_mouse_position())
	return tile_map.get_cell_source_id(terrain, clicked_cell) != -1

func collect_resources():
	var mined = {}
	for node in get_children():
		if node.is_in_group("miner"):
			mined.merge(node.mined)
	for node in mined:
		var item : InventoryItem = node.item
		#print("mining %s" % item)
		player_inventory.insert(item, item.collection_rate)

func craft_recipes():
	for node in get_children():
		if node.is_in_group("crafter"):
			node.craft_recipe()

func _on_collection_timer_timeout():
	craft_recipes()
	collect_resources()
