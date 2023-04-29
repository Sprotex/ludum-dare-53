extends Node3D

class_name BoxPicker

@export var box_weilder: BoxWeilder
@export var ray_cast: RayCast3D
@export var shape_cast: ShapeCast3D


func pickup(box: Box) -> void:
  box_weilder.set_box(box)


func _process(_delta: float) -> void:
  if not Input.is_action_just_pressed("box_action"):
    return
  if box_weilder.has_box():
    return
  var ray_cast_collider = ray_cast.get_collider()
  if not ray_cast_collider or not ray_cast_collider is Box:
    return
  if shape_cast.is_colliding():
    return
  pickup(ray_cast_collider)