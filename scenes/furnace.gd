extends StaticBody2D

@export var recipe_list : Array[Recipe]

@onready var world = get_tree().current_scene

var recipe : Recipe = null

func _ready():
	global.selection_changed.connect(selection_changed)

func selection_changed(selected : Node):
	if selected != self:
		deselect()

func _process(delta):
	if recipe:
		$Sprite2D.modulate = Color(1, 1, 1, 1)
	else:
		$Sprite2D.modulate = Color(1, 0, 0, 0.8)

func _input(event):
	#print(event)
	if global.selection == self and event.is_action_pressed("recipe"):
		#print("open recipe list")
		$RecipeList.show_recipes(recipe_list)

	#if clickable and event is InputEventMouseButton and event.pressed and !event.double_click and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		#print("clicked furnace")
		#select()

func select():
	scale = Vector2(1.1, 1.1)
	global.select_node(self)

func deselect():
	scale = Vector2(1.0, 1.0)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and !event.double_click and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		#print("clicked furnace")
		select()

