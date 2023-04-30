extends Node3D

class_name AnimationPlayerRelay

@export var animation_tree: AnimationTree

func animation_event(event_name: String) -> void:
  match event_name:
    "step":
      GameEvents.on_stepped.emit(global_position)