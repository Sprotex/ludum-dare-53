extends Node3D

class_name BlockDudeRelay

@export var animation_tree: AnimationTree
@export var mesh: MeshInstance3D

func animation_event(event_name: String) -> void:
  match event_name:
    "step":
      GameEvents.on_stepped.emit(global_position)
