class_name Inventory
extends Resource

signal update

@export var slots : Array[InventorySlot]

func insert(item : InventoryItem, count : int = 1):
	var item_slots = slots.filter(func(slot): return slot.item == item)
	if !item_slots.is_empty():
		item_slots[-1].amount += count
	else:
		var empty_slots = slots.filter(func(slot): return slot.item == null)
		if !empty_slots.is_empty():
			empty_slots[0].item = item
			empty_slots[0].amount = count
	update.emit()