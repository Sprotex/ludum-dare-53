extends Node3D

class_name BoxWeilder

var current_box = null


func has_box() -> bool:
	return current_box != null


func set_box(box: Node3D) -> void:
	current_box = box
	if box.get_parent() == null:
		box.position = position
		add_child(box)
