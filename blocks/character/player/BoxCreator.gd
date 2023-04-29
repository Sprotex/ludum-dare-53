extends Node

class_name BoxCreator

@export var box_weilder: BoxWeilder
@export var box_scene_holder: BoxSceneHolder
@export var body: CharacterBody3D
@export var ray_cast: RayCast3D

func create() -> void:
	var box = box_scene_holder.create_instance()
	var tween = get_tree().create_tween()
	tween.bind_node.call_deferred(box)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_method(box.change_visual_scale, Vector3.ZERO, Vector3.ONE, 0.5)
	box_weilder.set_box(box)


func _process(delta: float) -> void:
	if not Input.is_action_just_pressed("box_action"):
		return
	if box_weilder.has_box():
		return
	if ray_cast.is_colliding() and ray_cast.get_collider() is Box:
		return
	create()
