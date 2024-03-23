extends Machine

@export var recipe_list : Array[Recipe]

var recipe : Recipe = null

func _ready():
	print(recipe_list)
	super()

func _process(delta):
	if recipe:
		$Sprite2D.modulate = Color(1, 1, 1, 1)
	elif not creating:
		$Sprite2D.modulate = Color(1, 0, 0, 0.8)
	if draggable and Input.is_action_just_pressed("recipe"):
		$RecipeList.show_recipes(recipe_list)
	super(delta)

func _on_recipe_list_recipe_changed(new_recipe):
	recipe = new_recipe

func craft_recipe():
	if recipe:
		recipe.craft(world.player_inventory)
