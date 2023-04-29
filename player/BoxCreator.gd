extends Node

class_name BoxCreator

@export var box_weilder: BoxWeilder
@export var box_scene_holder: BoxSceneHolder

func create() -> void:
	var box = box_scene_holder.create_instance()
	box_weilder.set_box(box)


func _process(delta: float) -> void:
	if not Input.is_action_just_pressed("box_action"):
		return
	if box_weilder.has_box():
		return
	create()
