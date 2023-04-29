extends Node

class_name BoxCreator

@export var box_weilder: BoxWeilder
@export var box_scene_holder: BoxSceneHolder
@export var body: CharacterBody3D

func create() -> void:
	var box = box_scene_holder.create_instance()
	body.add_collision_exception_with(box)
	var tween = get_tree().create_tween()
	tween.bind_node(box)
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC).tween_property(box, "scale", Vector3.ONE, 0.5).from(Vector3.ZERO)
	box_weilder.set_box(box)


func _process(delta: float) -> void:
	if not Input.is_action_just_pressed("box_action"):
		return
	if box_weilder.has_box():
		return
	create.call_deferred()
