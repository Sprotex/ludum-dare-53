extends Node

@export var box_weilder: BoxWeilder

func throw_box() -> void:
	var box = box_weilder.get_and_reset_box()
	box.freeze = false
	var box_global_position = box.global_position
	box.get_parent().remove_child(box)
	LevelReference.level.boxes.add_child(box)
	box.global_position = box_global_position

func _process(delta: float) -> void:
	if not Input.is_action_just_pressed("box_action"):
		return
	if not box_weilder.has_box():
		return
	throw_box.call_deferred()
