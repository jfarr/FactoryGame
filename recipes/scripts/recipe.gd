class_name Recipe
extends Resource

@export var name : String
@export var machine : String
@export var inputs : Array[InventorySlot]
@export var outputs : Array[InventorySlot]

func craft(inventory : Inventory):
	if can_craft(inventory):
		for slot in inputs:
			inventory.remove(slot.item, slot.amount)
		for slot in outputs:
			inventory.insert(slot.item, slot.amount)

func can_craft(inventory : Inventory):
	for slot in outputs:
		if not inventory.can_insert(slot.item, slot.amount):
			return false
	for slot in inputs:
		if inventory.count_items(slot.item) < slot.amount:
			return false
	return true
