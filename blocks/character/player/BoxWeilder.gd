extends Node3D

class_name BoxWeilder

var current_box: Box = null

@export var body: CharacterBody3D


func has_box() -> bool:
  return current_box != null


func get_and_reset_box() -> Box:
  var box = current_box
  current_box = null
  return box

func _assign_box_variable(box: Box) -> void:
  current_box = box

func set_box(box: Box) -> void:
  var box_parent = box.get_parent()
  if box_parent:
    box_parent.remove_child(box)
  add_child(box)
  box.freeze = true
  box.add_collision_exception_with(body)
  box.global_position = global_position
  box.global_rotation = global_rotation
  _assign_box_variable.call_deferred(box)
  