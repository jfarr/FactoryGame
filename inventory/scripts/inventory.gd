class_name Inventory
extends Resource

signal update

@export var slots : Array[InventorySlot]

var max_items = 100

func can_insert(item : InventoryItem, count : int = 1):
	return count_items(item) + count <= max_items

func insert(item : InventoryItem, count : int = 1):
	var item_slots = slots.filter(func(slot): return slot != null and slot.item == item)
	if !item_slots.is_empty():
		item_slots[-1].amount += count
		item_slots[-1].amount = min(item_slots[-1].amount, max_items)
	else:
		var empty_slots = slots.filter(func(slot): return slot != null and slot.item == null)
		if !empty_slots.is_empty():
			empty_slots[0].item = item
			empty_slots[0].amount = min(count, max_items)
		else:
			var slot = InventorySlot.new()
			slot.item = item
			slot.amount = min(count, max_items)
			slots.append(slot)
	update.emit()
	#print(slots)

func remove(item : InventoryItem, count : int = 1):
	var item_slots = slots.filter(func(slot): return slot != null and slot.item == item)
	for slot in item_slots:
		if slot.amount >= count:
			slot.amount -= count
			if slot.amount == 0:
				slot.item = null
		else:
			count -= slot.amount
			slot.item = null
			slot.amount = 0
			if count <= 0:
				break
	update.emit()
	#print(slots)

func count_items(item : InventoryItem):
	#var current_count = 0
	var item_slots = slots.filter(func(slot): return slot != null and slot.item == item)
	return item_slots.map(func(item): return item.amount).reduce(func(a, b): return a + b, 0)
