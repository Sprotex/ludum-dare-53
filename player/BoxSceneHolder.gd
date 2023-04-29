extends Node

class_name BoxSceneHolder

@export var box_scene: PackedScene

func create_instance() -> Node3D:
	var instance = box_scene.instantiate()
	return instance
