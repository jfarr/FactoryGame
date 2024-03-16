extends Panel

signal recipe_selected(recipe)

var recipe
var selected = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func update(item : InventoryItem, selected : bool):
	recipe = item
	$Sprite2D.texture = item.texture
	$Label.text = item.name
	$CheckBox.set_pressed(selected)

func _on_check_box_toggled(toggled_on):
	if toggled_on:
		select_recipe()
	else:
		selected = false

func select_recipe():
	selected = true
	recipe_selected.emit(recipe)

func deselect_recipe():
	selected = false
	$CheckBox.set_pressed(false)
