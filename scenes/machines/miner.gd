extends Machine

var mined = {}
var to_mine = {}

func start_dragging():
	if not global.is_dragging:
		$CollectionArea.visible = true
		to_mine = {}
	super()
	
func cancel_drag():
	$CollectionArea.visible = false
	super()

func finish_dragging():
	$CollectionArea.visible = false
	mined = to_mine
	to_mine = {}
	super()

func _on_collection_area_body_entered(body):
	if body.is_in_group("mineral"):
		to_mine[body] = 1

func _on_collection_area_body_exited(body):
	if body.is_in_group("mineral"):
		to_mine.erase(body)
