extends Node2D

@onready var inventory =get_tree().current_scene.player_inventory
@onready var slots : Array = $GridContainer.get_children()

func _ready():
	inventory.update.connect(update_slots)
	update_slots()

func update_slots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])

func _process(delta):
	pass
