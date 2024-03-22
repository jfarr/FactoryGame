extends PanelContainer

signal recipe_changed(recipe)

var slot_scene : PackedScene = preload("res://recipes/scenes/recipe_slot.tscn")
var selected_recipe = null

func _ready():
	hide()

func _process(delta):
	pass

func _unhandled_key_input(event):
	if event.is_action_pressed("cancel"):
		hide()

func show_recipes(recipe_list : Array[Recipe]):
	if not $GridContainer.get_children():
		for recipe in recipe_list:
			var slot = slot_scene.instantiate()
			slot.recipe_selected.connect(recipe_selected)
			slot.update(recipe, recipe == selected_recipe)
			$GridContainer.add_child(slot)
	show()

func recipe_selected(recipe):
	#print("selected: %s" % recipe)
	selected_recipe = recipe
	if recipe:
		for slot in $GridContainer.get_children():
			if slot.recipe != recipe:
				slot.deselect_recipe()
	recipe_changed.emit(recipe)
