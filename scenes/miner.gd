extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	deselect()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func select():
	$CollectionArea.visible = true

func deselect():
	$CollectionArea.visible = false

func _on_input_event(viewport, event, shape_idx):
	#print(event)
	if event is InputEventMouseButton and event.pressed and !event.double_click and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		select()
		 
