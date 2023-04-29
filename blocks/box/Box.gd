extends RigidBody3D

class_name Box

@export var mesh: MeshInstance3D

var was_refrozen_since_instantiation = false

func is_deliverable() -> bool:
  return !was_refrozen_since_instantiation and !freeze


func change_visual_scale(new_scale: Vector3) -> void:
  mesh.scale = new_scale


func _on_sleeping_state_changed():
  if not sleeping:
    return
  if freeze:
    return
  was_refrozen_since_instantiation = true
