extends Node3D

class_name BoxWeilder

var current_box: Box = null


func has_box() -> bool:
	return current_box != null


func get_and_reset_box() -> Box:
	var box = current_box
	current_box = null
	return box


func set_box(box: Box) -> void:
	if box.get_parent() == null:
		box.position = position
		add_child(box)
	current_box = box
