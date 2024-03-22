extends Panel

@onready var item_visual : Sprite2D = $ItemSprite
@onready var amount_text : Label = $Label

func _ready():
	item_visual.scale = Vector2(1, 1)
	item_visual.visible = false
	amount_text.visible = false

func _process(delta):
	pass

func update(slot: InventorySlot):
	if slot and slot.item:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		amount_text.visible = slot.amount > 1
		amount_text.text = str(slot.amount)
	else:
		item_visual.visible = false
		amount_text.visible = false
