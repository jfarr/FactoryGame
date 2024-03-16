class_name Recipe
extends Resource

@export var name : String
@export var machine : String
@export var inputs : Array[InventorySlot]
@export var output : InventorySlot
@export var byproducts : Array[InventorySlot]

func can_build(inventory : Inventory):
	for slot in inputs:
		if inventory.count_items(slot.item) < slot.amount:
			return false
	return true

func build(inventory : Inventory):
	pass
