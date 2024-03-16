extends Node2D

signal selection_changed(selected : Node)

var is_dragging = false
var selection : Node = null

func select_node(node : Node):
	#if selection:
		#selection.deselect()
	selection = node
	selection_changed.emit(node)
